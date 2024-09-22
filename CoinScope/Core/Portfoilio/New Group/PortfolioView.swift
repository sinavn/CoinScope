//
//  PortfolioView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/26/1403 AP.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject var viewModel : PortfolioViewModel
    
    enum NavigationDestination : Hashable {
        case CoinDetailView(CoinModel)
        case addListView
        case editCoinView(CoinModel)
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath, root:{
            ZStack{
                if viewModel.holdings.isEmpty{
                    emptyStateView
                }else{
                    holdingsView
                }
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .CoinDetailView(let coin):
                    CoinDetailView()
                        .environmentObject(CoinDetailViewModel(coin: coin))
                case .addListView :
                    AddListView()
                case .editCoinView(let coin):
                    AddCoinView(coin: coin)
                }
            }
           
            .navigationTitle("Portfolio")
            .navigationBarTitleDisplayMode(.inline)
        })
       
    }
}

#Preview {
    PortfolioView()
        .environmentObject(PortfolioViewModel())
}

extension PortfolioView {
    var holdingsView : some View{
        
        ZStack{
            List{
                    Rectangle()
                        .fill(Color.theme.BackgroundColor)
                        .frame(width:nil , height: 130)
                        .listRowSeparator(.hidden, edges: .all)
                    ForEach($viewModel.holdings){ $coin in
                        PortfolioCoinRowView(coin: $coin )
                            .onTapGesture {
                                viewModel.navigationPath.append(NavigationDestination.CoinDetailView(coin))
                            }
                            .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                            .swipeActions(allowsFullSwipe: true) {
                                Button(role: .destructive, action: {
                                    viewModel.updateCoin(coin: coin, amount: 0)
                                }, label: {
                                    Label("Delete", systemImage: "trash")
                                })
                                Button(action: {
                                    viewModel.navigationPath.append(NavigationDestination.editCoinView(coin))
                                }, label: {
                                    Label("edit", systemImage: "pencil.circle")
                                })
                                .tint(.blue)
                            }
                    }

                    
                    
                HStack(alignment:.center){
                    Button(action: {viewModel.navigationPath.append(NavigationDestination.addListView)},
                           label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.theme.accentColor.opacity(0.6))
                    })
                    .frame(maxWidth: .infinity, maxHeight: 30)
                }
                .listRowSeparator(.hidden, edges: .all)

            }
            .listStyle(.plain)
            .toolbar {
//                EditButton()
            }
            VStack{
                headerView
                Spacer()
            }
            
        }
        
    }
    
    var headerView : some View{
        VStack(alignment:.leading){
            Text("Est. Assets")
                .font(.caption)
            Text(viewModel.holdingsValue.asCurrencyWith6Decimals())
                
                .font(.title)
        }
        .frame(maxWidth: .infinity , maxHeight: 130 , alignment:.leading)
        .padding(.horizontal)
        .background(.ultraThinMaterial)
    }
    
    var emptyStateView : some View {
        VStack{
            NoHoldingsView(onButtonTap: {
                viewModel.navigationPath.append(NavigationDestination.addListView)
            })
        }
    }
}

//
//  HomeView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/26/1403 AP.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel : HomeViewModel
    
    var body: some View {
        
        NavigationStack{
            ScrollView{
                LazyVStack(content: {
                    Section {
                        ForEach(viewModel.allCoins) { coin in
                            CoinRowView(coin: coin, showHoldingsCulomn: false)
                        }
                    } header: {
                        listTitles
                            .background ()
                    }
                    
                    
                })
            }
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarTrailing) {
                            Image(systemName: "person.crop.circle")
                        }
                       
                    })
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Live Market")
            .onAppear(perform: {
//                Task{
//                    await viewModel.getCoins()
//                }
            })
            
        }
        .searchable(text: $viewModel.homeSearchField)
    }
    
    
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
extension HomeView {
    
    private var listTitles : some View {
        HStack {
            HStack(spacing: 3){
                VStack(spacing:2){
                    Image(systemName: "chevron.up")
                        .opacity(viewModel.sortOption == .coin && viewModel.isAscending == false ? 1 : 0.3)
                    Image(systemName: "chevron.down")
                        .opacity(viewModel.sortOption == .coin && viewModel.isAscending == true ? 1 : 0.3)
                }
                .font(.caption2)
                Text("Coin")
            }
            .onTapGesture(perform: {
                viewModel.toggleSort(option: .coin)
            })
            .frame(width: 120 , alignment: .center)
            
            Spacer()
            
            HStack(spacing : 3){
                HStack{
                    VStack(spacing:2){
                        Image(systemName: "chevron.up")
                            .opacity(viewModel.sortOption == .price && viewModel.isAscending == false ? 1 : 0.3)
                        Image(systemName: "chevron.down")
                            .opacity(viewModel.sortOption == .price && viewModel.isAscending == true ? 1 : 0.3)
                    }
                    .font(.caption2)
                    Text("Price")
                }
                .onTapGesture(perform: {
                    viewModel.toggleSort(option: .price)
                })
                Text(" / ")
                HStack{
                    VStack(spacing:2){
                        Image(systemName: "chevron.up")
                            .opacity(viewModel.sortOption == .change24H && viewModel.isAscending == false ? 1 : 0.3)
                        Image(systemName: "chevron.down")
                            .opacity(viewModel.sortOption == .change24H && viewModel.isAscending == true ? 1 : 0.3)
                        
                    }
                    .font(.caption2)
                    Text("24H Chg")
                }
                .onTapGesture(perform: {
                    viewModel.toggleSort(option: .change24H)
                })
            }
            .frame(width: 130 , alignment: .center)
            
        }
        .font(.caption)
    }
    
//    private var coinList : some View {
//        List() {
//            ForEach(viewModel.allCoins) { coin in
//                CoinRowView(coin: coin, showHoldingsCulomn: false)
//            }
//            .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 5))
//        }
//        .listStyle(.plain)
//        
//    }
}

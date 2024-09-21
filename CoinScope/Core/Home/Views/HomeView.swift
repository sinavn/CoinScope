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
        NavigationStack(path: $viewModel.homeNavigationPath, root: {
            ScrollView{
                VStack{
                    homeGlobalStats
                    coinList
                }
                .navigationDestination(for: CoinModel.self) { coin in
                    CoinDetailView()
                        .environmentObject(CoinDetailViewModel(coin: coin))
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "person.crop.circle")
                }
                
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Live Market")
            .onAppear(perform: {
                
            })
            
        })
        .searchable(text: $viewModel.homeSearchField, prompt:"Search for coin")
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
    
    private var coinList : some View {
        LazyVStack(content: {
            Section {
                ForEach(viewModel.allCoins) { coin in
                    CoinRowView(coin: coin, showHoldingsCulomn: false)
                        .onTapGesture {
                            viewModel.homeNavigationPath.append(coin)
                        }
                }
                .animation(.default, value: viewModel.allCoins)
            } header: {
                listTitles
                    .background ()
            }
        })
        .clipped()
    }
    
    private var homeGlobalStats : some View{
        HStack{
            StatisticView(stats: StatisticModel(title: "market Cap", value: viewModel.homeMarketData?.marketCap ?? "nil" , changePrecent: viewModel.homeMarketData?.marketCapChangePercentage24HUsd))
            Spacer()
            StatisticView(stats: StatisticModel(title: "market volume", value: viewModel.homeMarketData?.marketVolume ?? "null"))
            Spacer()
            StatisticView(stats: StatisticModel(title: "Dominance", value: viewModel.homeMarketData?.dominance ?? "null"))
        }
        .padding(.horizontal)
    }
    
}

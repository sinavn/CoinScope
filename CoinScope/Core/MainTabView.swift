//
//  HomeView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/23/1403 AP.
//

import SwiftUI
import Combine

struct MainTabView: View {
    
//    @State private var isShowPortfolio = false
//    @State var coinList : [CoinModel] = []
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var portfolioViewModel = PortfolioViewModel()
    @State var homeViewModelAllCoinsSubscription : AnyCancellable?
    var body: some View {
        TabView {
            // MARK: -  Home

            HomeView()
                .environmentObject(homeViewModel)
                .tabItem {
                    Label("Live Market", systemImage: "chart.bar")
                }
            
            // MARK: -  market overview

            MarketDataView()
                .tabItem {
                    Label("Market OverView", systemImage: "globe")
                }
            
            // MARK: -  portfolio

            PortfolioView()
                .environmentObject(portfolioViewModel)
                .tabItem {
                    Label("Portfolio", systemImage: "bag")
                }
        }
        .onAppear {
            homeViewModelAllCoinsSubscription = homeViewModel.$allCoins
                .sink { coins in
                    portfolioViewModel.coinList = coins
//                    homeViewModelAllCoinsSubscription?.cancel()
                }
                
                
        }
        .tabViewStyle(.automatic)
        

    }
}

#Preview {
    NavigationStack{
        MainTabView()
            .toolbar(.hidden)
    }
}

extension MainTabView {
//    private var homeHeader : some View{
//        HStack{
//            CircleButton(buttonTitle: isShowPortfolio ? "plus" : "info")
//                .contentTransition(.symbolEffect(.replace))
//            
//            Spacer()
//            Text(isShowPortfolio ? "live market" : "portfolio")
//                .foregroundStyle(Color.theme.accentColor)
//                .font(.headline)
//                .fontWeight(.heavy)
//                .contentTransition(.numericText())
//            Spacer()
//            CircleButton(buttonTitle: "chevron.right")
//                .onTapGesture(perform: {
//                    withAnimation(.bouncy) {
//                        isShowPortfolio.toggle()
//                    }
//                })
//                .rotationEffect(Angle(degrees: isShowPortfolio ? 180 : 0))
//        }
//        
//    }
    
   
}


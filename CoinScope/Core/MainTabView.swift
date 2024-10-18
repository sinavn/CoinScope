//
//  HomeView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/23/1403 AP.
//

import SwiftUI
import Combine

struct MainTabView: View {
    

    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var portfolioViewModel = PortfolioViewModel()
    @StateObject private var settingViewModel = SettingViewModel()
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
            // MARK: -  setting
            
            SettingView()
                .environmentObject(settingViewModel)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }

        }
        .onAppear {
            homeViewModelAllCoinsSubscription = homeViewModel.$allCoins
                .sink { coins in
                    portfolioViewModel.coinList = coins
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



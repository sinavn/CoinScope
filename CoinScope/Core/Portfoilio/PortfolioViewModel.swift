//
//  PortfolioViewModel.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/26/1403 AP.
//

import Foundation
import SwiftUI
import Combine

class PortfolioViewModel : ObservableObject {
    
    @Published var Holdings : [CoinModel] = []
    @Published var coinList : [CoinModel] = []
    @Published var addCoinSearchField = ""
    @Published var navigationPath = NavigationPath()
    var filteredCoins : [CoinModel]{
        filterCoins(text: addCoinSearchField, coins: coinList)
    }
    init() {
  
    }
 
    
    private func filterCoins(text:String , coins : [CoinModel])->[CoinModel]{
        guard !text.isEmpty else{
            return coins.sorted(by: {$0.marketCapRank < $1.marketCapRank})
        }
        let lowerCasedText = text.lowercased()
        return coins.filter({
            $0.name.contains(lowerCasedText)||$0.symbol.contains(lowerCasedText)||$0.id.contains(lowerCasedText)
        }).sorted(by: {$0.marketCapRank < $1.marketCapRank})
    }
    
    
}

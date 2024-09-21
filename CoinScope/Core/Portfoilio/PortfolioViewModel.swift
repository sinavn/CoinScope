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
    @Published var coinList : [CoinModel] = []
    
    @Published var holdings : [CoinModel] = []
    @Published var addCoinSearchField = ""
    @Published var navigationPath = NavigationPath()
    private var portfolioCancellables = Set<AnyCancellable>()
    var holdingsValue : Double {
        holdings.reduce(0, {$0 + ($1.currentHoldingValue ?? 0)})
        
    }
    var filteredCoins : [CoinModel]{
        filterCoins(text: addCoinSearchField, coins: coinList)
    }
    
    
    init() {
        addCoreDataSubscriber()
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
    
    private func addCoreDataSubscriber(){
        $coinList
            .combineLatest(CoreDataService.shared.$savedEntities)
            .map { (coins , entities) ->[CoinModel] in
                coins
                    .compactMap { coin -> CoinModel? in
                        guard let entity = entities.first(where: {$0.coinID == coin.id})else{
                            return nil
                        }
                        return coin.updateHolding(amount: entity.amount)
                    }
            }
            .sink {[weak self] fetchedCoins in
                self?.holdings = fetchedCoins
            }
            .store(in: &portfolioCancellables)
    }
    func updateCoin(coin:CoinModel , amount : Double){
        CoreDataService.shared.updatePortfolio(coin: coin, amount: amount)
        
//        if let updatingCoinIndex = holdings.firstIndex(where: {$0.name == coin.name}){
//            holdings[updatingCoinIndex].currentHoldings = (holdings[updatingCoinIndex].currentHoldings ?? 0) + amount
//            
//        }else{
//            let newCoin = coin.updateHolding(amount: amount)
//            holdings.append(newCoin)
//        }
    }
}

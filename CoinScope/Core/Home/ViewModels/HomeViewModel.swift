//
//  HomeViewModel.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/26/1403 AP.
//

import Foundation
import Combine
class HomeViewModel : ObservableObject {
    ///------Home Objects---
    @Published var allCoins : [CoinModel] = []
    @Published var homeMarketData : GlobalMarketDataModel?
    ///------sort objects---
    @Published var homeSearchField = ""
    @Published var isAscending : Bool = true
    @Published var sortOption : SortOption = .coin
    ///------services------
    let coindataService = CoinDataService()
    let globalDataService = GlobalDataService()
    var cancellables = Set<AnyCancellable>()
    
    ///------------------
    
    enum SortOption {
        case coin , price , change24H
    }
    
    init() {
        addCoinDataSubscriber()
        addGlobalDataService()
    }
    // MARK: -  functions
    
    private func addCoinDataSubscriber(){
        $homeSearchField
            .combineLatest(coindataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink {[weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    private func addGlobalDataService(){
        globalDataService.$globalMarketData
            .sink {[weak self] recievedGlobalData in
                self?.homeMarketData = recievedGlobalData
            }
            .store(in: &cancellables)
    }
    private func filterCoins (text : String , coins : [CoinModel])->[CoinModel]{
        guard !text.isEmpty else{
            return coins
        }
        let lowerCasedText = text.lowercased()
        return coins.filter({
            $0.name.contains(lowerCasedText)||$0.symbol.contains(lowerCasedText)||$0.id.contains(lowerCasedText)
        })
    }
    
    
    private func sortCoins (){
        switch sortOption{
        case .coin :
            allCoins.sort(by: { isAscending ? $0.marketCapRank < $1.marketCapRank : $0.marketCapRank > $1.marketCapRank} )
        case .price:
            allCoins.sort(by: { isAscending ? $0.currentPrice < $1.currentPrice : $0.currentPrice > $1.currentPrice} )
        case .change24H:
            allCoins.sort(by: { isAscending ? $0.priceChangePercentage24H ?? 0 < $1.priceChangePercentage24H ?? 0 : $0.priceChangePercentage24H ?? 0 > $1.priceChangePercentage24H ?? 0} )
        }
    }
    
    func toggleSort (option : SortOption){
        if option == sortOption{
            isAscending.toggle()
        }else{
            sortOption = option
            isAscending = false
        }
        sortCoins()
    }
    
}

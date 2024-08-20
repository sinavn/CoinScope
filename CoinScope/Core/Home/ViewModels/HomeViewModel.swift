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
    @Published var homeSearchField = ""
    ///------sort objects---
    @Published var isAscending : Bool = true
    @Published var sortOption : SortOption = .coin
    ///------services------
    let coindataService = CoinDataService()
    var cancellables = Set<AnyCancellable>()
    
    
    ///------------------
    
    enum SortOption {
        case coin , price , change24H
    }
    
    init() {
        addCoinDataSubscriber()
    }
    // MARK: -  functions

    func addCoinDataSubscriber(){
        coindataService.$allCoins
            .sink {[weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
//    func getCoins()async{
//        do {
//            let coins = try await DownloadManager.shared.getCoinData()
//            await MainActor.run {
//                allCoins = coins
//            }
//        } catch let error {
//            print(error)
//        }
//    }
    
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

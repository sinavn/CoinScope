//
//  CoinDetailViewModel.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/31/1403 AP.
//

import Foundation
import Combine

class CoinDetailViewModel : ObservableObject {
    @Published var coinDetail: CoinDetailModel?
    var coin : CoinModel
    let coinDetailService : CoinDetailService
    var cancellables = Set<AnyCancellable>()
    
    init(coin : CoinModel) {
        self.coin = coin
        coinDetailService = CoinDetailService(coinID: coin.id)
        addCoinDataSubscriber()
    }
    
    private func addCoinDataSubscriber (){
        coinDetailService.$coinDetail
            .sink {[weak self] recievedCoinDetail in
                self?.coinDetail = recievedCoinDetail
            }
            .store(in: &cancellables)
    }
    
}

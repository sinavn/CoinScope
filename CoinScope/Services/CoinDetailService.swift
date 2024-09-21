//
//  CoinDetailService.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/31/1403 AP.
//

import Foundation
import Combine

class CoinDetailService {
    @Published var coinDetail : CoinDetailModel?
    var coinsSubscription : AnyCancellable?
    
    init(coinID:String) {
        getCoinDetails(coinID: coinID)
    }
    
    func getCoinDetails(coinID:String){
        guard let url = URL(string: Constants.CGBaseURL+"/coins/\(coinID)?x_cg_demo_api_key="+Constants.CGAPIkey+"&localization=false&tickers=false&community_data=false&developer_data=false&market_data=false#") else {return}
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        coinsSubscription = NetworkinManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: decoder)
            .sink(receiveCompletion: NetworkinManager.handleCompletion, receiveValue: {[weak self] result in
                self?.coinDetail = result
                self?.coinsSubscription?.cancel()
            })
    }
}

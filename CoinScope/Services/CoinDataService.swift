//
//  CoinDataService.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/27/1403 AP.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins : [CoinModel] = []
    var coinsSubscription : AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins(){
        guard let url = URL(string: Constants.base_url+"/coins/markets?x_cg_demo_api_key="+Constants.apikey+"&vs_currency=usd&sparkline=true&price_change_percentage=24h&order=market_cap_desc") else {return}
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        coinsSubscription = NetworkinManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: decoder)
            .sink(receiveCompletion: NetworkinManager.handleCompletion, receiveValue: {[weak self] result in
                self?.allCoins = result
                self?.coinsSubscription?.cancel()
            })
            
             

    }
}

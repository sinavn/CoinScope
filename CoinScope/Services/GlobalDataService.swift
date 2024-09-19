//
//  GlobalDataService.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/29/1403 AP.
//

import Foundation
import SwiftUI
import Combine

class GlobalDataService{
    @Published var globalMarketData : GlobalMarketDataModel?
    private var subscription : AnyCancellable?
    init() {
        getData()
    }
    
    private func getData (){
        guard let url = URL(string: Constants.CGBaseURL + "/global?x_cg_demo_api_key=" + Constants.CGAPIkey) else{return}
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        subscription = NetworkinManager.download(url: url)
            .decode(type: GlobalDataModel.self, decoder: decoder)
            .sink(receiveCompletion: NetworkinManager.handleCompletion, receiveValue: {[weak self] recievedData in
                self?.globalMarketData = recievedData.data
                self?.subscription?.cancel()
            })
        
    }
}

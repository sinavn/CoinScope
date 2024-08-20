//
//  CoinImageService.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/30/1403 AP.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    @Published var image :UIImage? = nil
    private var imageSubscription : AnyCancellable?
    private let coin : CoinModel
    init(coin : CoinModel){
        self.coin = coin
        getCoinImage()
    }
    
    func getCoinImage (){
        guard let url = URL(string: coin.image) else {return}
        
         imageSubscription = NetworkinManager.download(url: url)
            .tryMap({ Data -> UIImage? in
                return UIImage(data: Data)
            })
            .sink(receiveCompletion: NetworkinManager.handleCompletion) {[weak self] returnedImage in
                if let image = returnedImage {
                    self?.image = image
                    self?.imageSubscription?.cancel()
                }
            }
            
    
    }
}

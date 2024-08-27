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
    private let fileManager = LocalFileManager.shared
    private let folderName = "coin_images"
    private let imageName : String
    
    init(coin : CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage(){
        if let savedImage = fileManager.getImage(imageName: coin.id, folderName: folderName){
            image = savedImage
        }else{
            downloadCoinImage()
        }
                
    }
    
    private func downloadCoinImage (){
        guard let url = URL(string: coin.image) else {return}
        
         imageSubscription = NetworkinManager.download(url: url)
            .tryMap({ Data -> UIImage? in
                return UIImage(data: Data)
            })
            .sink(receiveCompletion: NetworkinManager.handleCompletion) {[weak self] returnedImage in
                guard let self = self else {return}
                if let image = returnedImage {
                    self.image = image
                    self.imageSubscription?.cancel()
                    self.fileManager.saveImage(image: image, imageName: self.coin.id, folderName: self.folderName)
                }
            }
            
    
    }
}

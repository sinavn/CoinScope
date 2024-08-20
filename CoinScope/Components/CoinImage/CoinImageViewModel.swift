//
//  CoinImageViewModel.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/30/1403 AP.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel : ObservableObject{
    @Published var coinImage : UIImage?  = nil
    @Published var isLoading : Bool = false
    private let coin : CoinModel
    private let imageService : CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin : CoinModel) {
        self.coin = coin
        self.imageService = CoinImageService(coin:coin)
        addImageSubscriber()
        self.isLoading = true
    }
    private func addImageSubscriber(){
        imageService.$image
            .sink(receiveCompletion: {[weak self] _ in
                self?.isLoading = false
            }, receiveValue: { [weak self]image in
                self?.coinImage = image
            })
            .store(in: &cancellables)
    }
}

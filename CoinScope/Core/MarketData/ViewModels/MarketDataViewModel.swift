//
//  MarketDataViewModel.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/13/1403 AP.
//

import SwiftUI
class MarketDataViewModel: ObservableObject {
    
    @Published var gwei : GweiModel?
    
    func getGasPrice () async {
        do {
            let result = try await NetworkinManager.getGasPrice()
            await MainActor.run {
                withAnimation {
                    gwei = result
                }
            }
        } catch let error  {
            print(error)
        }
    }
}

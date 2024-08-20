//
//  CoinImageView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/30/1403 AP.
//

import SwiftUI



struct CoinImageView: View {
    @StateObject var viewModel : CoinImageViewModel
    
    init(coin : CoinModel) {
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    var body: some View {
        ZStack{
            if let image = viewModel.coinImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }else if viewModel.isLoading == true{
                ProgressView()
            }else{
                Image(systemName: "photo.circle.fill")
                    .foregroundStyle(Color.theme.SecondaryTextColor)
            }
        }
    }
}

struct CoinImageView_previews:PreviewProvider{
    static var previews: some View {
        CoinImageView(coin: dev.coin)
    }
}

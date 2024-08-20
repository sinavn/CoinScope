//
//  CoinRowView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/25/1403 AP.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    let showHoldingsCulomn : Bool
    
    var body: some View {
        
                HStack(){
                    leftColumn
                    Spacer()
                    if showHoldingsCulomn{
                        centerCulomn
                    }
                   rightColumn
                }
    }
}

struct CoinRowView_Previews:PreviewProvider{
    static var previews: some View {
        CoinRowView(coin: dev.coin, showHoldingsCulomn: true)
            .previewLayout(.sizeThatFits)
    }
}

extension CoinRowView {
    private var leftColumn : some View {
        HStack{
            Text("\(coin.marketCapRank)")
                .font(.caption)
                .foregroundStyle(Color.theme.SecondaryTextColor)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 40 , height: 40)
            Text("\(coin.symbol.uppercased())")
                .font(.headline)
                .padding(.leading , 6)
                .foregroundStyle(Color.theme.accentColor)
        }
    }
    
    private var centerCulomn : some View {
        
        VStack(alignment: .trailing ){
            Text(coin.currentHoldingValue?.asCurrencyWith6Decimals() ?? "$0.0")
                .bold()
            Text(coin.currentHoldings?.asNumberString() ?? " 0.0")
        }      


    }
    
    private var rightColumn : some View {
            VStack(alignment:.trailing){
                Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
                Text(coin.priceChangePercentage24H?.asPercentString() ?? "0.00%")
                    .foregroundStyle(
                        (coin.priceChange24H ?? 0) >= 0 ? Color.theme.GreenColor : Color.theme.RedColor
                    )
            }
            .frame(width: 100,alignment: .trailing)
            .padding(.trailing , 5)
        
    }
}


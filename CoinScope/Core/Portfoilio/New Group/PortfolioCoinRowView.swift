//
//  PortfolioCoinRowView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/30/1403 AP.
//

import SwiftUI

struct PortfolioCoinRowView: View {
    
    @Binding var coin : CoinModel
    
    var body: some View {
        
        HStack(){
            leftColumn
            Spacer()
            centerCulomn
            
            rightColumn
        }
        .background(Color.theme.BackgroundColor.opacity(0.01))

    }
}

//#Preview {
//    PortfolioCoinRowView()
//}
extension PortfolioCoinRowView {
    private var leftColumn : some View {
        HStack{
            //            Text("\(coin.marketCapRank)")
            //                .font(.caption)
            //                .foregroundStyle(Color.theme.SecondaryTextColor)
            //                .frame(minWidth: 30)
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
        }
        
        
    }
    
    private var rightColumn : some View {
        VStack(alignment:.trailing){
            Text(coin.currentHoldings?.asNumberString() ?? " 0.0")

//            Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
//            Text(coin.priceChangePercentage24H?.asPercentString() ?? "0.00%")
//                .foregroundStyle(
//                    (coin.priceChange24H ?? 0) >= 0 ? Color.theme.GreenColor : Color.theme.RedColor
//                )
        }
        .frame(width: 100,alignment: .trailing)
        .padding(.trailing , 5)
        
    }
}

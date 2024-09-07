//
//  MarketData.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/13/1403 AP.
//

import SwiftUI

struct MarketDataView: View {
    @ObservedObject var viewModel : MarketDataViewModel = MarketDataViewModel()
    var body: some View {
        
        VStack{
            gweiTrackerView
        }
        
        .task({
            await viewModel.getGasPrice()
            
        })
    }
}
extension MarketDataView {
    var gweiTrackerView : some View{
        VStack{
            HStack{Text("Gas Tracker")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.theme.accentColor)
                ExpandableInfoView(text: "Powered by Etherscan")}
            HStack(spacing:50){
                if viewModel.gwei == nil {
                    ProgressView()
                }else{
                    GweiCardView(gasPrice: viewModel.gwei?.low ?? 0, speed: "slow 🐢")
                    GweiCardView(gasPrice: viewModel.gwei?.average ?? 0, speed: "standard 🚗")
                    GweiCardView(gasPrice: viewModel.gwei?.high ?? 0, speed: "fast 🚀")
                }
            }
            .frame(maxHeight: 45)
        }
        .padding(.horizontal)
        .padding(.bottom , 20)
        .frame(maxWidth: .infinity )
        .background(content: {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.secondary.opacity(0.3).gradient)
        })
    }
}

#Preview {
    MarketDataView()
}

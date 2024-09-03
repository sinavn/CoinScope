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
        
        HStack(spacing:50){
            if viewModel.gwei == nil {
                ProgressView()
            }else{
                Text(viewModel.gwei?.low.asNumberString() ?? "0")
                Text(viewModel.gwei?.average.asNumberString() ?? "0")
                Text(viewModel.gwei?.high.asNumberString() ?? "0")
            }
        
        }
        .padding()
        .contentTransition(.numericText())
        .frame(maxWidth: .infinity)
        .background(content: {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.secondary.opacity(0.3).gradient)
        })
        
        .task({
            await viewModel.getGasPrice()
            
        })
    }
}

#Preview {
    MarketDataView()
}

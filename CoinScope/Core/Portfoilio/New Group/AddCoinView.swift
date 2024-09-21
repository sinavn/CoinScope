//
//  AddCoinView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/30/1403 AP.
//

import SwiftUI

struct AddCoinView: View {
    @EnvironmentObject var viewModel : PortfolioViewModel
    @State var coin : CoinModel
    @State var coinAmountTextField : String = ""

    var body: some View {
        VStack{
            TextField("", text: $coinAmountTextField, prompt: Text("ex: 0.23 "))
                .frame(maxWidth: .infinity , maxHeight: 40)
                .foregroundStyle(Color.theme.accentColor)
                .padding(.horizontal)
                .background(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.theme.BackgroundColor)
                        .shadow(color: Color.theme.accentColor.opacity(0.3), radius: 10 , y: 5)
                })
                .keyboardType(.decimalPad)
                .padding()
            
            Button(action: {
                addCoin()
                viewModel.navigationPath = NavigationPath()
            }, label: {
                Text("Add \(coin.name)")
                    .frame(maxWidth: .infinity , maxHeight: 40)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.purple)
                    }
                    .padding(.horizontal)
            })
        }
        .navigationTitle("\(coin.symbol)")
    }
        
    
    private func addCoin (){
        viewModel.updateCoin(coin: coin, amount: Double(coinAmountTextField) ?? 0)
    }
}


struct AddCoinView_Previews:PreviewProvider{
    static var previews: some View {
        AddCoinView(coin: dev.coin)
            .previewLayout(.sizeThatFits)
    }
}

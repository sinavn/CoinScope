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
    @State var isAmountValid : Bool = false
    
    
    var body: some View {
        ScrollView{
            VStack{
                ChartView(coin: coin)
                VStack (spacing: 20){
                    HStack{
                        Text("current price of \(coin.symbol ) ")
                        Spacer()
                        Text(coin.currentPrice.asCurrencyWith6Decimals())
                    }
                    Divider()
                    HStack {
                        Text("amount holding:")
                        Spacer()
                        TextField("Ex: 2.3", text: $coinAmountTextField)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                    Divider()
                    HStack{
                        Text("Current value:")
                        Spacer()
                        Text(getCurrentValue().asCurrencyWith6Decimals())
                    }
                }
                .animation(.default, value:0.2)
                .padding()
                

            }
        }
        .onChange(of: coinAmountTextField, { _, newValue in
            if !newValue.isEmpty {
                    isAmountValid = true
            }else{
                isAmountValid = false
            }
        })
        .onAppear(perform: {
            coinAmountTextField = viewModel.holdings.first(where: {$0.id==coin.id})?.currentHoldings?.asNumberString() ?? ""
        })
        .toolbar{
            ToolbarItem(placement:.principal) {
                toolbarTrailingItems
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    if isAmountValid{
                        addCoin()
                        viewModel.navigationPath = NavigationPath()
                    }
                }, label: {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(isAmountValid ? Color.theme.SecondAccentColor : .background.opacity(0.0))
                })
                .animation(.default, value: isAmountValid)
            }
        }
        
    }
    
    
    private func addCoin (){
        viewModel.updateCoin(coin: coin, amount: Double(coinAmountTextField) ?? 0)
    }
    
    private func getCurrentValue ()->Double{
        if let quantity = Double(coinAmountTextField){
            return quantity * (coin.currentPrice)
        }
        return 0
    }
}


struct AddCoinView_Previews:PreviewProvider{
    static var previews: some View {
        AddCoinView(coin: dev.coin)
            .previewLayout(.sizeThatFits)
    }
}
extension AddCoinView {
    
    private var toolbarTrailingItems: some View {
        HStack {
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.SecondaryTextColor)
            CoinImageView(coin: coin)
                .frame(width: 25, height: 25)
        }
    }
}

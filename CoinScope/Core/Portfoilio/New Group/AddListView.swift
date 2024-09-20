//
//  AddCoinView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/30/1403 AP.
//

import SwiftUI

struct AddListView: View {
    @EnvironmentObject var viewModel : PortfolioViewModel
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(viewModel.filteredCoins){ coin in
                    CoinRowView(coin: coin, showHoldingsCulomn: true)
                        .onTapGesture {
                            viewModel.navigationPath.append(coin)
                        }
                }
            }
            .navigationDestination(for: CoinModel.self) { coin in
                AddCoinView(coin: coin)
            }
        }
        .searchable(text: $viewModel.addCoinSearchField)
    }
}

#Preview {
    AddListView()
        .environmentObject(PortfolioViewModel())
}

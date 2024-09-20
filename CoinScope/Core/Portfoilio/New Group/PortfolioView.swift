//
//  PortfolioView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/26/1403 AP.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject var viewModel : PortfolioViewModel
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath, root:{
            ZStack{
                if viewModel.Holdings.isEmpty{
                    emptyStateView
                }else{
                    holdingsView
                }
            }
            .navigationDestination(for: String.self) { _ in
                AddListView()
            }
        })
    }
}

#Preview {
    PortfolioView()
        .environmentObject(PortfolioViewModel())
}

extension PortfolioView {
    var holdingsView : some View{
        ScrollView{
            LazyVStack{
                ForEach(viewModel.Holdings){ coin in
                    CoinRowView(coin: coin, showHoldingsCulomn: true)
                }
                Button("add", action: {
                    viewModel.navigationPath.append("navigateToCoinList")
                })
            }
        }
    }
    
    var emptyStateView : some View {
        VStack{
        NoHoldingsView(onButtonTap: {
            viewModel.navigationPath.append("navigateToCoinList")
        })
        }
    }
}

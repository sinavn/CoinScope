//
//  CoinDetailView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/31/1403 AP.
//

import SwiftUI

struct CoinDetailView: View {
    @EnvironmentObject var viewModel : CoinDetailViewModel
   
    
    private let gridColumns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let vGridSpacing = 30.0
    var body: some View {
        ScrollView{
            VStack(spacing: 20) {
                ChartView(coin: viewModel.coin)
                
                overviewTitle
                Divider()
                overviewGrid
                
                additionalTitle
                Divider()
                additionalGrid
                
            }
            .padding()
        }
        .toolbar{
            ToolbarItem(placement:.principal) {
                toolbarTrailingItems
            }
        }
        .navigationTitle(viewModel.coin.name)
        .navigationBarTitleDisplayMode(.large)
        
    }
}

//#Preview {
//    CoinDetailView()
//}

extension CoinDetailView {
    
    private var toolbarTrailingItems: some View {
        HStack {
            Text(viewModel.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.SecondaryTextColor)
            CoinImageView(coin: viewModel.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accentColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accentColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    
    private var overviewGrid: some View {
        LazyVGrid(columns: gridColumns,
                  alignment: .leading,
                  spacing: vGridSpacing,
                  content: {
            ForEach(viewModel.overviewStatistics) { stat in
                StatisticView(stats: stat)
            }
        })
    }
    
    private var additionalGrid: some View {
        LazyVGrid(columns: gridColumns,
                  alignment: .leading,
                  spacing: vGridSpacing,
                  content: {
            ForEach(viewModel.additionalStatistics) { stat in
                StatisticView(stats: stat)
            }
        })
    }
    
}

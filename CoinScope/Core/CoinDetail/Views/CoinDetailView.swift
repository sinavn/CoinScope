//
//  CoinDetailView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/31/1403 AP.
//

import SwiftUI

struct CoinDetailView: View {
    @State private var isDescriptionExpanded : Bool = false
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
                coinDescription
                overviewTitle
                Divider()
                overviewGrid
                additionalTitle
                Divider()
                additionalGrid
                links
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
    private var coinDescription : some View{
        VStack{
            if let description = viewModel.coinDescription {
                Text(description)
                    .lineLimit(isDescriptionExpanded ? nil : 3)
                    .overlay(alignment: .bottomTrailing) {
                       
                        Button(action: {
                            withAnimation {
                                isDescriptionExpanded.toggle()
                            }
                        }, label: {
                            Text(isDescriptionExpanded ? "less" : "see more")
                                .font(.caption)
                                .foregroundStyle(.blue)
                                .padding(.leading, 30)
                                .padding(.top , 5)
                                .background {
                                    LinearGradient(colors: [.clear , .background , .background , .background], startPoint: .leading, endPoint: .trailing)
                                }
                                .offset(y: isDescriptionExpanded ? 20 : 0)
                        })
                    }
            }
        }
    }
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
    
    private var links : some View {
        HStack (spacing : 30){
            if let urlString = viewModel.websiteURL , let url = URL(string: urlString){
                Link(destination: url) {
                    HStack {
                        Image(systemName: "globe")
                        Text("website")
                    }
                    .font(.body)
                }
            }
            
            if let urlString = viewModel.redditURL , let url = URL(string: urlString){
                Link(destination: url) {
                    HStack{
                        Image("reddit_Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("reddit")
                    }
                    .font(.body)
                }
            }
            
            if let urlString = viewModel.gitHubURL , let url = URL(string: urlString){
                Link(destination: url) {
                    HStack{
                        Image("githubLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("github")
                    }
                    .font(.body)
                }
            }
            
        }
        .frame(maxWidth: .infinity , maxHeight: 30)
    }
    
}

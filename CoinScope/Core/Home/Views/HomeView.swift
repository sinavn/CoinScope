//
//  HomeView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/23/1403 AP.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isShowPortfolio = false
    @State var coinList : [CoinModel] = []
    var body: some View {
        ZStack {
            Color.theme.BackgroundColor
                .ignoresSafeArea()
            VStack{
                homeHeader
                Spacer()
                coinListView
            }
        }
        .onAppear {
            Task{
               await getCoins()
            }
        }
    }
     func getCoins()async{
        do {
            let coins = try await DownloadManager.shared.getCoinData()
            coinList = coins
        } catch let error {
            print(error)
        }
    }
}

#Preview {
    NavigationStack{
        HomeView()
            .toolbar(.hidden)
    }
}

extension HomeView {
    private var homeHeader : some View{
        HStack{
            CircleButton(buttonTitle: isShowPortfolio ? "plus" : "info")
                .contentTransition(.symbolEffect(.replace))
            
            Spacer()
            Text(isShowPortfolio ? "live market" : "portfolio")
                .foregroundStyle(Color.theme.accentColor)
                .font(.headline)
                .fontWeight(.heavy)
                .contentTransition(.numericText())
            Spacer()
            CircleButton(buttonTitle: "chevron.right")
                .onTapGesture(perform: {
                    withAnimation(.bouncy) {
                        isShowPortfolio.toggle()
                    }
                })
                .rotationEffect(Angle(degrees: isShowPortfolio ? 180 : 0))
        }
        
    }
    
    private var coinListView : some View {
        List {
            ForEach(coinList) { coin in
                Text(coin.name ?? "none")
            }
        }
    }
}


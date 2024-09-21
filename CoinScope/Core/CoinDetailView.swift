//
//  CoinDetailView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/31/1403 AP.
//

import SwiftUI

struct CoinDetailView: View {
    @State var coin : CoinModel
   
    var body: some View {
        Text("\(coin.name)!")
    }
}

//#Preview {
//    CoinDetailView()
//}

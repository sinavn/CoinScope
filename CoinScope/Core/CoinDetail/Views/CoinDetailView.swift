//
//  CoinDetailView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/31/1403 AP.
//

import SwiftUI

struct CoinDetailView: View {
    @EnvironmentObject var viewModel : CoinDetailViewModel
   
    var body: some View {
        
        Text(viewModel.coinDetail?.description?.en ?? "no description")
    }
}

//#Preview {
//    CoinDetailView()
//}

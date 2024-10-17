//
//  GweiCardView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/17/1403 AP.
//

import SwiftUI

struct GweiCardView: View {
    var gasPrice : Double
    var speed : String
    var body: some View {
        VStack(alignment:.center){
            Text(speed)
                .foregroundStyle(.gray)
                .fontWeight(.semibold)
            Text(gasPrice.asNumberString())
                .fontWeight(.bold)
                .font(.title)
                
        }
        .contentTransition(.numericText())
    }
}

#Preview {
    GweiCardView(gasPrice: 1.92, speed: "slow 🐢")
}

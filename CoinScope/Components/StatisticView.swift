//
//  StatisticView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/19/1403 AP.
//

import SwiftUI

struct StatisticView: View {
    let stats : StatisticModel
    var body: some View {
        VStack(alignment:.leading , spacing: 4){
            Text(stats.title)
                .font(.caption)
                .foregroundStyle(Color.theme.SecondaryTextColor)
            Text(stats.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accentColor)
            
            HStack{
                Image(systemName: "triangleshape.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stats.changePrecent ?? 0) >= 0 ? 0 : 180 ))
                Text(stats.changePrecent?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle((stats.changePrecent ?? 0) >= 0 ? Color.theme.GreenColor : Color.theme.RedColor )
            .opacity(stats.changePrecent == nil ? 0 : 1)
        }
    }
}

struct StatisticView_Previews : PreviewProvider {
    static var previews: some View{
        
        StatisticView(stats: dev.stat3)
    }
}

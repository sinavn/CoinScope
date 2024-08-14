//
//  CircleButton.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/23/1403 AP.
//

import SwiftUI


struct CircleButton: View {
    
    let buttonTitle : String

    var body: some View {
        Image(systemName: buttonTitle)
            .font(.headline)
            .foregroundStyle(Color.theme.accentColor)
            .frame(width: 50,height: 50)
            .background {
                Circle()
                    .foregroundStyle(Color.theme.BackgroundColor)
            }
            .shadow(color: Color.theme.accentColor.opacity(0.25),
                    radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .padding()
       }
}

#Preview() {
    CircleButton(buttonTitle: "info")
        .previewLayout(.sizeThatFits)
}

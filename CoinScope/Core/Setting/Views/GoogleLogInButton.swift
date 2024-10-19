//
//  GoogleLogInButton.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 7/27/1403 AP.
//

import SwiftUI

struct GoogleLogInButton: View {
    @EnvironmentObject var viewModel : SettingViewModel
    var body: some View {
        Button(action: {
            viewModel.signIn()
        }, label: {
            HStack{
                Image("Google_Icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("Sign in with Google")
                Spacer()
            }
            .frame(maxWidth: .infinity ,maxHeight: 40 )
            .padding(.horizontal)
        })
    }
}

//#Preview {
//    GoogleLogInButton()
//}

//
//  SettingViewModel.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 7/22/1403 AP.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

class SettingViewModel : ObservableObject {
    
    @Published var isLoggedIn = false
    @Published var username : String?
    @Published var profilePic : URL?
    @Published var isShowingSignOutAlert : Bool = false
    @Published var isNotificationsEnabled = true
    @Published var notificationFrequency = 0
    @Published var selectedCurrency = "USD"
    @Published var isDarkMode = false
    @Published var selectedLanguage = "en"
    @Published var isPasscodeEnabled = false
    @Published var isFaceIDEnabled = false
    @Published var navigationPath = NavigationPath()
    
     init() {
        
    }
    
    func handleSignIn() {
        guard let rootViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) {[weak self] signResult, error in
            guard error == nil , let result = signResult  else{
                print("google sign in error \(error?.localizedDescription ?? "")")
                return
            }
            self?.username = result.user.profile?.name
            self?.profilePic = result.user.profile?.imageURL(withDimension: 90)
            self?.isLoggedIn = true
            self?.navigationPath = NavigationPath()
        }
    }
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        isLoggedIn = false
    }
    
    func checkSignInStatus (){
        GIDSignIn.sharedInstance.restorePreviousSignIn {[weak self] signResult, error in
            guard error == nil , let result = signResult  else{
                print("user did not sign in yet:  \(error?.localizedDescription ?? "")")
                self?.isLoggedIn = false
                return
            }
            self?.username = result.profile?.name
            self?.profilePic = result.profile?.imageURL(withDimension: 90)
            self?.isLoggedIn = true
        }
    }
    
}

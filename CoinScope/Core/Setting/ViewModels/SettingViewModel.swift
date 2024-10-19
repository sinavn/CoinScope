//
//  SettingViewModel.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 7/22/1403 AP.
//

import SwiftUI

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
    let fireBaseService = FireBaseService.shared
    
    func signIn() {
        fireBaseService.handleSignIn {[weak self] result in
            switch result {
            case.success(let user):
                self?.username = user.displayName
                self?.profilePic = user.photoURL
                self?.isLoggedIn = true
                self?.navigationPath = NavigationPath()
            case.failure(let error):
                print(error)
                self?.isLoggedIn = false
            }
        }
        
    }
    func signOut(){
        fireBaseService.signOut {[weak self] result in
            switch result {
            case.success():
                self?.isLoggedIn = false
            case.failure(let error):
                self?.isLoggedIn = true
            }
        }
    }
    
    func checkSignInStatus(){
        fireBaseService.checkSignInStatus {[weak self] result in
            switch result {
            case.success(let user):
                self?.username = user.displayName
                self?.profilePic = user.photoURL
                self?.isLoggedIn = true
            case.failure(let error):
                self?.isLoggedIn = false
                print(error)
            }
        }
        
    }
    
}

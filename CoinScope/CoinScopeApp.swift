//
//  CoinScopeApp.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/22/1403 AP.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn


@main
struct CoinScopeApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
                MainTabView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}

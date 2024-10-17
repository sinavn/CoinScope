//
//  SettingView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 7/22/1403 AP.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn

struct SettingView: View {
    @State private var isLoggedIn = false
    @State private var username = "John Doe"
    @State private var isNotificationsEnabled = true
    @State private var notificationFrequency = 0
    @State private var selectedCurrency = "USD"
    @State private var isDarkMode = false
    @State private var selectedLanguage = "en"
    @State private var isPasscodeEnabled = false
    @State private var isFaceIDEnabled = false
    
    var body: some View {
        NavigationStack {

            Form {
                // Login Section
                Section {
//                    if isLoggedIn {
//                        HStack {
//                            Image(systemName: "person.circle.fill")
//                                .resizable()
//                                .frame(width: 50, height: 50)
//                                .clipShape(Circle())
//                            
//                            VStack(alignment: .leading) {
//                                Text(username)
//                                    .font(.headline)
//                                Button(action: {
//                                    // Logout action
//                                    isLoggedIn = false
//                                }) {
//                                    Text("Logout")
//                                        .foregroundColor(.red)
//                                }
//                            }
//                        }
//                    } else {
//                        Button(action: {
//                            // Login action
//                        }) {
//                            HStack {
//                                Image(systemName: "person.crop.circle.badge.plus")
//                                Text("Login / Sign up")
//                            }
//                        }
//                    }
                    GoogleSignInButton(action: handleSignIn)
                }
                
                // General settings
                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $isNotificationsEnabled)
                    Picker("Notification Frequency", selection: $notificationFrequency) {
                        Text("Hourly").tag(0)
                        Text("Daily").tag(1)
                    }
                    
                }
                
                Section(header: Text("Currency")) {
                    Picker("Currency", selection: $selectedCurrency) {
                        Text("USD").tag("USD")
                        Text("EUR").tag("EUR")
                        Text("GBP").tag("GBP")
                    }
                }
                
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }
                
                Section(header: Text("Language")) {
                    Picker("App Language", selection: $selectedLanguage) {
                        Text("English").tag("en")
                        Text("Spanish").tag("es")
                        Text("French").tag("fr")
                    }
                }
                
                // Security settings
                Section(header: Text("Security")) {
                    Toggle("Enable Passcode", isOn: $isPasscodeEnabled)
                    Toggle("Use Face ID", isOn: $isFaceIDEnabled)
                }
                
                // Data Management
                Section(header: Text("Data Management")) {
                    Button("Backup Portfolio") {
                        // Backup logic
                    }
                    Button("Clear Cache") {
                        // Clear cache logic
                    }
                }
                
                // About
                Section(header: Text("About")) {
                    HStack {
                        Text("App Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.gray)
                    }
                    NavigationLink("Privacy Policy", destination: Text("Privacy Policy Content"))
                    NavigationLink("Terms of Service", destination: Text("Terms of Service Content"))
                    NavigationLink("Support", destination: Text("Support Information"))
                    NavigationLink("FAQ", destination: Text("Frequently Asked Questions"))
                }
                
                // Feedback
                Section {
                    Button("Send Feedback") {
                        // Feedback form logic
                    }
                    Button("Rate Us on App Store") {
                        // Redirect to App Store page
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    func handleSignIn() {
        guard let rootViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if error == nil{
                print(result?.user.profile?.name)
            }else{
                print(error)
            }
        }
    }
}


#Preview {
    SettingView()
}

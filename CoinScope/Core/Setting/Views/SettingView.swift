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
    @EnvironmentObject var viewModel : SettingViewModel
    
    enum SettingsNavigationDestination : Hashable {
    case logInView
    case privacyPolicy
    case terms
    case support
    case faq
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath, root: {

            Form {
                // Login Section
                Section {
                    if viewModel.isLoggedIn {
                        HStack {
                            AsyncImage(url: viewModel.profilePic)
                                
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(viewModel.username ?? "")
                                    .font(.headline)
                                
                                    Text("Logout")
                                        .foregroundColor(.red)
                                        .onTapGesture {
                                            viewModel.isShowingSignOutAlert.toggle()
                                        }
                            }
                            .alert("Are you sure you want to sign out", isPresented: $viewModel.isShowingSignOutAlert) {
                                Button(role: .destructive, action: viewModel.signOut, label: {Text("Sign out")})
                                Button(role: .cancel, action: {}, label: {Text("Cancel")})
                            }
                        }
                    } else {
                        Button(action: {
                            viewModel.navigationPath.append(SettingsNavigationDestination.logInView)
                        }) {
                            HStack {
                                Image(systemName: "person.crop.circle.badge.plus")
                                Text("Login / Sign up")
                            }
                        }
                        
                    }
                }
                
                // General settings
                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $viewModel.isNotificationsEnabled)
                    Picker("Notification Frequency", selection: $viewModel.notificationFrequency) {
                        Text("Hourly").tag(0)
                        Text("Daily").tag(1)
                    }
                    
                }
                
                Section(header: Text("Currency")) {
                    Picker("Currency", selection: $viewModel.selectedCurrency) {
                        Text("USD").tag("USD")
                        Text("EUR").tag("EUR")
                        Text("GBP").tag("GBP")
                    }
                }
                
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $viewModel.isDarkMode)
                }
                
                Section(header: Text("Language")) {
                    Picker("App Language", selection: $viewModel.selectedLanguage) {
                        Text("English").tag("en")
                        Text("Spanish").tag("es")
                        Text("French").tag("fr")
                    }
                }
                
                // Security settings
                Section(header: Text("Security")) {
                    Toggle("Enable Passcode", isOn: $viewModel.isPasscodeEnabled)
                    Toggle("Use Face ID", isOn: $viewModel.isFaceIDEnabled)
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
                    Button(action: {
                        viewModel.navigationPath.append(SettingsNavigationDestination.privacyPolicy)
                    }, label: {
                        HStack {
                            Text("Privacy Policy")
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.gray)
                        }
                    })
                    Button(action: {
                        viewModel.navigationPath.append(SettingsNavigationDestination.terms)
                    }, label: {
                        HStack {
                            Text("Terms of Service")
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.gray)
                        }
                    })
                    Button(action: {
                        viewModel.navigationPath.append(SettingsNavigationDestination.support)
                    }, label: {
                        HStack {
                            Text("Support")
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.gray)
                        }
                    })
                    Button(action: {
                        viewModel.navigationPath.append(SettingsNavigationDestination.faq)
                    }, label: {
                        HStack {
                            Text("FAQ")
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.gray)
                        }
                    })
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
            .navigationDestination(for: SettingsNavigationDestination.self) { destination in
                switch destination {
                case .logInView:
                    LogInView()
                case .privacyPolicy:
                    Text("Privacy policy")
                case .terms:
                    Text("terms of service")
                case .support:
                    Text("aupport")
                case .faq:
                    Text("FAQ")
                }
            }
            .navigationTitle("Settings")
        })
        .onAppear {
            viewModel.checkSignInStatus()
        }
    }
    
    
}


#Preview {
    SettingView()
}



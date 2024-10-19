//
//  FireBaseService.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 7/28/1403 AP.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth


class FireBaseService {
    static let shared = FireBaseService()
    
    private init (){}
    
    func handleSignIn(completion : @escaping (Result<User,Error>)->Void) {
        
        guard let rootViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
            completion(.failure(NSError(domain: "no RootViewController found for google sign in", code: 1)))
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signResult, error in
            if let error = error {
                print("google sign in error \(error)")
                completion(.failure(error))
                return
            }
            
            guard let signedUser = signResult?.user ,
                  let idToken = signedUser.idToken?.tokenString  else{
                completion(.failure(NSError(domain: "Google sign in token error", code: 2)))
                return
            }
            
            let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: signedUser.accessToken.tokenString)
            
            Auth.auth().signIn(with: credentials) { result, error in
                if let error = error {
                    print("firebase sign in error \(error)")
                }
                if let user = result?.user {
                    completion(.success(user))
                }else{
                    completion(.failure(NSError(domain: "FireBase user not found ", code: 3)))
                }
            }
        }
    }
    
    func signOut(completion:@escaping (Result<Void , Error>)-> Void){
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch let error {
            print("error signing out \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    
    func checkSignInStatus (completion:@escaping (Result<User,Error>)->Void){
        
        if let user = Auth.auth().currentUser {
            completion(.success(user))
        }else{
            completion(.failure(NSError(domain: "user is not signed in", code: 1)))
        }
    }
}

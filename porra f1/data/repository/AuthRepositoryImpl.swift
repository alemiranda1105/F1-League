//
//  AuthRepositoryImpl.swift
//  F1 League
//
//  Created by Alejandro Miranda on 8/4/23.
//

import Foundation
import FirebaseAuth

class AuthRepositoryImpl: AuthRepository {
    var currentUser: User? = Auth.auth().currentUser
    
    func listenToAuthState(completion: @escaping (_ authUser: User?, _ error: String) -> Void) -> AuthStateDidChangeListenerHandle {
        return Auth.auth().addStateDidChangeListener { _, user in
            guard user != nil else {
                completion(nil, "user-not-found-error")
                return
            }
            completion(user, "")
        }
    }
    
    func signUpWithEmailAndPassowrd(emailAddress: String, password: String) async -> (User?, String) {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: emailAddress, password: password)
            print(authResult)
            return (authResult.user, "")
        } catch {
            print(error.localizedDescription)
            return (nil, error.localizedDescription)
        }
    }
    
    func signInWithEmailAndPassword(email: String, password: String) async -> (User?, String) {
        return (nil, "")
    }
    
    
}

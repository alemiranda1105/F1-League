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
    
    
    func revokeAccess() async {
        do {
            try await Auth.auth().currentUser?.delete()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}

//
//  AuthRepositoryImpl.swift
//  F1 League
//
//  Created by Alejandro Miranda on 8/4/23.
//

import Foundation
import FirebaseAuth

class AuthRepositoryImpl: AuthRepository {
    let auth = FirebaseAuth.Auth.auth()
    var currentUser: User? = Auth.auth().currentUser
    
    func signUpWithEmailAndPassword(emailAddress: String, password: String) async -> (User?, String) {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: emailAddress, password: password)
            self.currentUser = authResult.user
            return (authResult.user, "")
        } catch {
            print(error.localizedDescription)
            print("WTFFFFF")
            return (nil, error.localizedDescription)
        }
    }
    
    func signInWithEmailAndPassword(email: String, password: String) async -> (User?, String) {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            self.currentUser = authResult.user
            return (authResult.user, "")
        } catch {
            print(error.localizedDescription)
            return (nil, error.localizedDescription)
        }
    }
    
    func updateAuthUser(newUser: AppUser, password: String) async -> (User?, String) {
        do {
            if let authUser = Auth.auth().currentUser {
                try await Auth.auth().signIn(withEmail: authUser.email!, password: password)
                try await authUser.updateEmail(to: newUser.email)
                return (authUser, "")
            }
            return (nil, "no-current-user-error")
        } catch {
            print(error.localizedDescription)
            return (nil, error.localizedDescription)
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
        } catch {
            print(error.localizedDescription)
        }
        self.currentUser = nil
    }
    
    
}

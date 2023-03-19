//
//  AuthViewModel.swift
//  porra f1
//
//  Created by Alejandro Miranda on 19/3/23.
//

import SwiftUI
import FirebaseAuth

final class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String = ""
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else {
                return
            }
            self.user = user
        }
    }
    
    @MainActor
    func signUp(emailAddress: String, password: String) async {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: emailAddress, password: password)
            self.user = authResult.user
        } catch {
            print("There was an error: \(error.localizedDescription)")
            self.errorMessage = error.localizedDescription
        }
    }
    
    @MainActor
    func signIn(email: String, password: String) async {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            self.user = authResult.user
        } catch {
            print("There was an error: \(error.localizedDescription)")
            self.errorMessage = error.localizedDescription
        }
    }
    
    func userIsSignedIn() -> Bool {
        return self.user != nil
    }
}

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
    @Published var appUser: AppUser?
    @Published var errorMessage: String = ""
    
    private let appUserService = AppUserService()
    
    @MainActor
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else {
                return
            }
            Task {
                let (userData, error) = await self.appUserService.getUserByEmail(_email: (user?.email) ?? "")
                // TODO: Set error when user is not found
                if error.isEmpty {
                    self.user = user
                    self.appUser = userData
                    UserDefaults.standard.set(self.appUser!.email, forKey: "userEmail")
                } else {
                    self.user = nil
                }
            }
        }
    }
    
    @MainActor
    func signUp(emailAddress: String, password: String) async {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: emailAddress, password: password)
            let (appUser, error) = await self.appUserService.createNewUser(_email: emailAddress)
            if error.isEmpty {
                self.user = authResult.user
                self.appUser = appUser
                UserDefaults.standard.set(self.appUser!.email, forKey: "userEmail")
            } else {
                throw "The user could not be created"
            }
            
        } catch {
            print("There was an error: \(error.localizedDescription)")
            self.errorMessage = error.localizedDescription
        }
    }
    
    @MainActor
    func signIn(email: String, password: String) async {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            let (appUser, error) = await self.appUserService.createNewUser(_email: email)
            if error.isEmpty {
                self.user = authResult.user
                self.appUser = appUser
                UserDefaults.standard.set(self.appUser!.email, forKey: "userEmail")
            } else {
                throw "The user could was not found"
            }
        } catch {
            print("There was an error: \(error.localizedDescription)")
            self.errorMessage = error.localizedDescription
        }
    }
    
    func userIsSignedIn() -> Bool {
        return self.user != nil
    }
}

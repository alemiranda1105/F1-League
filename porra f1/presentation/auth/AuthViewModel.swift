//
//  AuthViewModel.swift
//  porra f1
//
//  Created by Alejandro Miranda on 19/3/23.
//

import SwiftUI
import FirebaseAuth

@MainActor class AuthViewModel: ObservableObject {
    @Published var authUser: User?
    @Published var appUser: AppUser?
    @Published var errorMessage: String = ""
    
    private let authService = AuthService()
    private let appUserService = AppUserService()
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { _, authUser in
            guard authUser != nil else {
                return
            }
            
            Task {
                let (userData, error) = await self.appUserService.getUserByEmail(email: (authUser?.email ?? ""))
                if error.isEmpty {
                    self.authUser = authUser
                    self.appUser = userData
                    UserDefaults.standard.set(self.authUser?.email, forKey: "userEmail")
                } else {
                    self.authUser = nil
                }
            }
        }
    }
    
    func signUp(emailAddress: String, password: String) async {
        let (authUser, error) = await authService.signUpWithEmailAndPassowrd(emailAddress: emailAddress, password: password)
        guard error == ""  else {
            print("There was an error: \(error)")
            self.errorMessage = error
            return
        }
        
        let (appUser, createUserError) = await self.appUserService.createNewUser(email: emailAddress)
        guard createUserError == ""  else {
            print("There was an error: \(createUserError)")
            self.errorMessage = createUserError
            return
        }
        
        self.authUser = authUser
        self.appUser = appUser
        UserDefaults.standard.set(self.appUser!.email, forKey: "userEmail")
    }
    
    func signIn(email: String, password: String) async {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            let (appUser, error) = await self.appUserService.createNewUser(email: email)
            if error.isEmpty {
                self.authUser = authResult.user
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
    
}

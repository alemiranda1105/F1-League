//
//  AuthViewModel.swift
//  porra f1
//
//  Created by Alejandro Miranda on 19/3/23.
//

import SwiftUI
import FirebaseAuth

@MainActor class AuthViewModel: ObservableObject {
    @Published var appUser: AppUser?
    @Published var errorMessage: String = ""
    
    private let authService = AuthService()
    private let appUserService = AppUserService()
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { _, authUser in
            guard authUser != nil else {
                self.appUser = nil
                return
            }
            
            Task {
                let (userData, error) = await self.appUserService.getUserByEmail(email: (authUser?.email ?? ""))
                if !error.isEmpty || userData == nil {
                    self.authService.signOut()
                    return
                }
                
                self.appUser = AppUser(id: userData!.id, email: userData!.email, username: userData!.username)
                UserDefaults.standard.set(self.appUser!.email, forKey: "userEmail")
            }
        }
    }
    
    func createAccount(emailAddress: String, password: String, username: String) async {
        let repeatedUser = await appUserService.searchUserByUsername(username: username)
        guard repeatedUser == nil else {
            self.errorMessage = "repeated-username"
            return
        }
        let (authUser, error) = await authService.signUpWithEmailAndPassowrd(emailAddress: emailAddress, password: password, username: username)
        
        guard error == ""  else {
            print("There was an error: \(error)")
            self.errorMessage = error
            return
        }
        
        guard authUser != nil else {
            print("User with email \(emailAddress) not found ")
            self.errorMessage = "user-not-found"
            return
        }
        
        let (appUser, createUserError) = await self.appUserService.createNewUser(newUser: AppUser(email: emailAddress, username: username))
        guard createUserError == ""  else {
            print("There was an error: \(createUserError)")
            self.errorMessage = createUserError
            return
        }
        
        self.appUser = appUser
        UserDefaults.standard.set(self.appUser!.email, forKey: "userEmail")
    }
    
    func signIn(email: String, password: String) async {
        let (authUser, error) = await authService.signInWithEmailAndPassowrd(emailAddress: email, password: password)
        guard error == ""  else {
            print("There was an error: \(error)")
            self.errorMessage = error
            return
        }
        
        guard authUser != nil else {
            print("User with email \(email) not found ")
            self.errorMessage = "user-not-found"
            return
        }
        
        let (appUser, errorMessage) = await self.appUserService.getUserByEmail(email: email)
        guard errorMessage == ""  else {
            print("There was an error: \(error)")
            self.errorMessage = error
            return
        }
        
        guard appUser != nil else {
            print("User with email \(email) not found ")
            self.errorMessage = "user-not-found"
            return
        }
        
        self.appUser = appUser
        UserDefaults.standard.set(self.appUser!.email, forKey: "userEmail")
    }
    
    func signOut() {
        authService.signOut()
        self.appUser = nil
    }

}

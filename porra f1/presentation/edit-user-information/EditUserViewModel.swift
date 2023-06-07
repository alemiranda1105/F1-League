//
//  EditUserViewModel.swift
//  F1 League
//
//  Created by Alejandro Miranda on 6/6/23.
//

import Foundation

@MainActor class EditUserViewModel: ObservableObject {
    private let authService = AuthService()
    private let appUserService = AppUserService()
    
    @Published var error = ""
    @Published var pending = false
    @Published var authUser: AppUser? = nil
    
    func updateUser(userId: String, newEmail: String, newUsername: String, password: String) async {
        self.pending = true
        let result = await self.appUserService.updateUser(user: AppUser(id: userId, email: newEmail, username: newUsername))
        if !result.error.isEmpty {
            self.error = error
            self.pending = false
            return
        }
        
        if let updatedUser = result.updatedUser {
            self.authUser = await updateAuthUser(newUser: updatedUser, password: password)
        }
        self.pending = false
    }
    
    private func updateAuthUser(newUser: AppUser, password: String) async -> AppUser? {
        let (user, error) = await self.authService.updateAuthUser(newUser: newUser, password: password)
        if !error.isEmpty {
            self.error = error
            self.pending = false
            return nil
        }
        guard let user = user else {
            self.error = "user-not-found"
            self.pending = false
            return nil
        }
        return AppUser(id: newUser.id, email: user.email!, username: newUser.username)
    }
}

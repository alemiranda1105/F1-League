//
//  UserProfileViewModel.swift
//  F1 League
//
//  Created by Alejandro Miranda on 8/4/23.
//

import Foundation

@MainActor class UserProfileViewModel: ObservableObject {
    private let authService = AuthService()
    private let appUserService = AppUserService()
    
    @Published var user: AppUser?
    @Published var pending: Bool = true
    
    init() {
        loadUser()
    }
    
    func signOut() {
        self.authService.signOut()
    }
    
    private func loadUser() {
        self.pending = false
        Task {
            self.user = await appUserService.getCurrentUser()!
            self.pending = false
        }
    }
}

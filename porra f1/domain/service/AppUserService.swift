//
//  AppUserService.swift
//  porra f1
//
//  Created by Alejandro Miranda on 30/3/23.
//

import Foundation
import FirebaseFirestore

class AppUserService {
    private let appUserRepository = UserRepositoryImpl()
    
    func getCurrentUser() async -> AppUser? {
        return await appUserRepository.getCurrentUser()
    }
    
    func getUserByEmail(email: String) async -> (AppUser?, String) {
        return await appUserRepository.getUserByEmail(email: email)
    }
    
    func searchUsersByEmail(email: String) async -> [AppUser] {
        return await appUserRepository.searchUsersByEmail(email: email)
    }
    
    
    func createNewUser(email: String) async -> (AppUser?, String) {
        return await appUserRepository.saveUser(email: email)
    }
    
}
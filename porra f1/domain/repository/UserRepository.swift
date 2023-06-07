//
//  UserRepository.swift
//  F1 League
//
//  Created by Alejandro Miranda on 8/4/23.
//

import Foundation

protocol UserRepository {
    
    func getCurrentUser() async -> AppUser?
    
    func getUserByEmail(email: String) async -> (AppUser?, String)
    
    func searchUsersByEmail(email: String) async -> [AppUser]
    
    func searchUserByUsername(username: String) async -> AppUser?
    
    func saveUser(newUser: AppUser) async -> (AppUser?, String)
    
    func updateUser(user: AppUser) async -> (updatedUser: AppUser?, error: String)
    
}

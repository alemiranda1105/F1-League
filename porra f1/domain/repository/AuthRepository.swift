//
//  AuthRepository.swift
//  F1 League
//
//  Created by Alejandro Miranda on 8/4/23.
//

import Foundation
import FirebaseAuth

protocol AuthRepository {
    var auth: Auth { get }
    var currentUser: User? { get set }
    
    func signUpWithEmailAndPassword(emailAddress: String, password: String) async -> (User?, String)
    
    func signInWithEmailAndPassword(email: String, password: String) async -> (User?, String)
    
    func updateAuthUser(newUser: AppUser, password: String) async -> (User?, String)
    
    func updatePassword(email: String, oldPassword: String, newPassword: String) async -> String
    
    func signOut()
}

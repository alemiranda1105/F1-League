//
//  AuthService.swift
//  F1 League
//
//  Created by Alejandro Miranda on 8/4/23.
//

import Foundation
import FirebaseAuth

class AuthService {
    private let authRepository: AuthRepository = AuthRepositoryImpl()
    
    func signUpWithEmailAndPassowrd(emailAddress: String, password: String, username: String) async -> (User?, String) {
        let (authUser, error) = await authRepository.signUpWithEmailAndPassword(emailAddress: emailAddress, password: password)
        guard authUser != nil && error.isEmpty else {
            return (nil, error)
        }
        
        return (authUser, error)
    }
    
    func signInWithEmailAndPassowrd(emailAddress: String, password: String) async -> (User?, String) {
        return await authRepository.signInWithEmailAndPassword(email: emailAddress, password: password)
    }
    
    func getCurrentUser() -> User? {
        return authRepository.currentUser
    }
    
    func signOut() {
        authRepository.signOut()
    }
    
}

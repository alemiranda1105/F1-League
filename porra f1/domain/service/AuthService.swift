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
    
    func listenToAuthState(completion: @escaping (_ authUser: User?, _ error: String) -> Void) -> AuthStateDidChangeListenerHandle {
        return authRepository.listenToAuthState(completion: completion)
    }
    
    func signUpWithEmailAndPassowrd(emailAddress: String, password: String) async -> (User?, String) {
        return await authRepository.signInWithEmailAndPassword(email: emailAddress, password: password)
    }
    
    func getCurrentUser() -> User? {
        return authRepository.currentUser
    }
    
}

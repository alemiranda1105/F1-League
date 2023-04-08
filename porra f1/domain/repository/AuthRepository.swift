//
//  AuthRepository.swift
//  F1 League
//
//  Created by Alejandro Miranda on 8/4/23.
//

import Foundation
import FirebaseAuth

protocol AuthRepository {
    var currentUser: User? { get set }
    
    func listenToAuthState(completion: @escaping (_ authUser: User?, _ error: String) -> Void) -> AuthStateDidChangeListenerHandle
    
    func signUpWithEmailAndPassowrd(emailAddress: String, password: String) async -> (User?, String)
    
    func signInWithEmailAndPassword(email: String, password: String) async -> (User?, String)
}

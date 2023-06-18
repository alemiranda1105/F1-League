//
//  UserRepositoryImpl.swift
//  F1 League
//
//  Created by Alejandro Miranda on 8/4/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserRepositoryImpl: UserRepository {
    private let appUserDb = Firestore.firestore()
    
    func getCurrentUser() async -> AppUser? {
        guard let userEmail = UserDefaults.standard.string(forKey: "userEmail") else {
            return nil
        }
        let (user, _) = await self.getUserByEmail(email: userEmail)
        return user
    }
    
    func getUserByEmail(email: String) async -> (AppUser?, String) {
        var user: AppUser? = nil
        var errorMessage = ""

        let ref = appUserDb.collection(FirestoreDocuments.USERS.rawValue)
        do {
            let snapshot = try await ref.whereField("email", isEqualTo: email).getDocuments()
            try snapshot.documents.forEach { document in
                let userData =  try document.data(as: AppUser.self)
                user = userData
            }
            if user == nil {
                throw "User not found"
            }
        } catch {
            print(error)
            errorMessage = error.localizedDescription
        }
        return (user, errorMessage)
    }
    
    func searchUsersByEmail(email: String) async -> [AppUser] {
        var users = [AppUser]()

        let ref = appUserDb.collection(FirestoreDocuments.USERS.rawValue)
        do {
            let snapshot = try await ref.getDocuments()
            try snapshot.documents.forEach { document in
                let userData =  try document.data(as: AppUser.self)
                if userData.email.contains(email) {
                    users.append(userData)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return users
    }
    
    func searchUserByUsername(username: String) async -> AppUser? {
        var user: AppUser? = nil
        
        let ref = appUserDb.collection(FirestoreDocuments.USERS.rawValue)
        do {
            let snapshot = try await ref.whereField("username", isEqualTo: username).getDocuments()
            try snapshot.documents.forEach { document in
                let userData =  try document.data(as: AppUser.self)
                user = userData
            }
        } catch {
            print(error)
        }
        return user
    }
    
    func saveUser(newUser: AppUser) async -> (AppUser?, String) {
        var user: AppUser? = nil
        var errorMessage = ""

        let ref = appUserDb.collection(FirestoreDocuments.USERS.rawValue)
        do {
            let snapshot = try await ref.addDocument(data: [
                "email": newUser.email,
                "username": newUser.username
            ])
            user = AppUser(id: snapshot.documentID ,email: newUser.email, username: newUser.username)
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
        return (user, errorMessage)
    }
    
    func updateUser(user: AppUser) async -> (updatedUser: AppUser?, error: String) {
        var updatedUser: AppUser? = nil
        var errorMesssage = ""

        let ref = appUserDb.collection(FirestoreDocuments.USERS.rawValue).document(user.id ?? "")
        do {
            try ref.setData(from: user, merge: false)
            updatedUser = try await ref.getDocument(as: AppUser.self)
        } catch {
            print(error.localizedDescription)
            errorMesssage = error.localizedDescription
        }
        return (updatedUser, errorMesssage)
    }
    
}

//
//  UserRepositoryImpl.swift
//  F1 League
//
//  Created by Alejandro Miranda on 8/4/23.
//

import Foundation
import FirebaseFirestore

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
        print(email)

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
    
    func saveUser(email: String) async -> (AppUser?, String) {
        var user: AppUser? = nil
        var errorMessage = ""

        let ref = appUserDb.collection(FirestoreDocuments.USERS.rawValue)
        do {
            let snapshot = try await ref.addDocument(data: [
                "email": email
            ])
            user = AppUser(id: snapshot.documentID ,email: email)
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
        return (user, errorMessage)
    }
    
    
}

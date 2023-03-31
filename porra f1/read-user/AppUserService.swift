//
//  AppUserService.swift
//  porra f1
//
//  Created by Alejandro Miranda on 30/3/23.
//

import Foundation
import FirebaseFirestore

class AppUserService {
    private let appUserDb = Firestore.firestore()
    
    func getCurrentUser() async -> AppUser? {
        guard let userEmail = UserDefaults.standard.string(forKey: "userEmail") else {
            return nil
        }
        let (user, _) = await self.getUserByEmail(_email: userEmail)
        return user
    }
    
    func getUserByEmail(_email: String) async -> (AppUser?, String) {
        var user: AppUser? = nil
        var errorMessage = ""

        let ref = appUserDb.collection(FirestoreDocuments.USERS.rawValue)
        do {
            let snapshot = try await ref.whereField("email", isEqualTo: _email).getDocuments()
            try snapshot.documents.forEach { document in
                let userData =  try document.data(as: AppUser.self)
                user = userData
            }
            if user == nil {
                throw "User not found"
            }
        } catch {
            print(error.localizedDescription)
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
    
    
    func createNewUser(_email: String) async -> (AppUser?, String) {
        var user: AppUser? = nil
        var errorMessage = ""

        let ref = appUserDb.collection(FirestoreDocuments.USERS.rawValue)
        do {
            let snapshot = try await ref.addDocument(data: [
                "email": _email
            ])
            user = AppUser(id: snapshot.documentID ,email: _email)
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
        return (user, errorMessage)
    }
    
}

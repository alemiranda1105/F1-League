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
    
    func getUserByEmail(_email: String) async -> (AppUser?, String) {
        var user: AppUser? = nil
        var errorMessage = ""

        let ref = appUserDb.collection(FirestoreDocuments.USERS.rawValue)
        do {
            let snapshot = try await ref.whereField("email", isEqualTo: _email).getDocuments()
            try snapshot.documents.forEach { document in
                let userData =  try document.data(as: AppUser.self)
                user = userData
                print(userData)
            }
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
        return (user, errorMessage)
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

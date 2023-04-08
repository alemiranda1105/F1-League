//
//  BetGroupsService.swift
//  porra f1
//
//  Created by Alejandro Miranda on 30/3/23.
//

import Foundation
import FirebaseFirestore

class BetGroupsService {
    private let betGroupsDb = Firestore.firestore()
    
    func loadUserGroups(userEmail: String) async -> ([BetGroup], String) {
        var groups = [BetGroup]()
        var errorMessage = ""
        
        let ref = betGroupsDb.collection(FirestoreDocuments.GROUPS.rawValue)
        do {
            let snapshot = try await ref.whereField("users", arrayContains: userEmail).getDocuments()
            try snapshot.documents.forEach { document in
                let betGroup =  try document.data(as: BetGroup.self)
                groups.append(betGroup)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        
        return (groups, errorMessage)
    }
    
    func saveGroup(group: BetGroup) -> String? {
        let ref = betGroupsDb.collection(FirestoreDocuments.GROUPS.rawValue)
        var errorMessage: String?
        do {
            let _ = try ref.addDocument(from: group) { error in
                if let error = error {
                    errorMessage = error.localizedDescription
                }
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        return errorMessage
    }
}

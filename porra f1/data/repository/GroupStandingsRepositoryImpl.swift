//
//  GroupStandingsRepositoryImpl.swift
//  F1 League
//
//  Created by Alejandro Miranda on 4/6/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class GroupStandingsRepositoryImpl: GroupStandingsRepository {
    private let groupStandingsDb = Firestore.firestore()
    
    func loadGroupStandings(groupId: String) async -> (groupStandings: GroupStandings?, error: String) {
        var standings: GroupStandings? = nil
        var errorMessage = ""
        
        let ref = groupStandingsDb.collection(FirestoreDocuments.GROUP_STANDINGS.rawValue)
        do {
            let snapshot = try await ref.whereField("groupId", isEqualTo: groupId).getDocuments()
            if let firstDocument = snapshot.documents.first {
                standings = try firstDocument.data(as: GroupStandings.self)
            } else {
                return (standings, "not-found-error")
            }
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
        
        return (standings, errorMessage)
    }
    
    
}

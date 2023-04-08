//
//  RaceRepositoryImpl.swift
//  F1 League
//
//  Created by Alejandro Miranda on 8/4/23.
//

import Foundation
import FirebaseFirestore

class RaceRepositoryImpl: RaceRepository {
    private let racesDb = Firestore.firestore()
    
    func getAllRaces() async -> (races: [Race], errorMessage: String) {
        var races = [Race]()
        var errorMessage = ""
        let ref = racesDb.collection(FirestoreDocuments.RACES.rawValue)
        do {
            let snapshot = try await ref.getDocuments()
            try snapshot.documents.forEach { document in
                let race =  try document.data(as: Race.self)
                races.append(race)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        return (races, errorMessage)
    }
    
    
}

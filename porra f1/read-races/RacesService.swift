//
//  RacesService.swift
//  porra f1
//
//  Created by Alejandro Miranda on 27/3/23.
//

import Foundation
import FirebaseFirestore

class RacesService: ObservableObject {
    private let racesDb = Firestore.firestore()
    
    func getAllRaces() async -> ([Race], String) {
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
        if !races.isEmpty {
            races = races.sorted { $0.round < $1.round }
        }
        return (races, errorMessage)
    }
}

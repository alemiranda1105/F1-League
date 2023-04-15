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
    
    func getRaceByRound(round: Int) async -> (race: Race?, errorMessage: String) {
        var race: Race? = nil
        var errorMessage = ""
        
        let ref = racesDb.collection(FirestoreDocuments.RACES.rawValue).whereField("round", isEqualTo: round)
        do {
            let document = try await ref.getDocuments().documents.first
            let raceData = try document?.data(as: Race.self)
            race = raceData
        } catch {
            print(error)
            errorMessage = error.localizedDescription
        }
        
        return (race, errorMessage)
    }
    
    
}

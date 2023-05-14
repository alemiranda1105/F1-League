//
//  RaceBetImpl.swift
//  F1 League
//
//  Created by Alejandro Miranda on 27/4/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class RaceBetImpl: RaceBetRepository {
    private let raceBetDb = Firestore.firestore()
    
    func saveRaceBet(newRaceBet: RaceBet) async -> (raceBet: RaceBet?, error: String) {
        var raceBet: RaceBet? = nil
        var errorMessage = ""

        let ref = raceBetDb.collection(FirestoreDocuments.RACE_BET.rawValue)
        do {
            let snapshot = try ref.addDocument(from: newRaceBet)
            raceBet = RaceBet(id: snapshot.documentID, betGroup: newRaceBet.betGroup, raceRound: newRaceBet.raceRound, userId: newRaceBet.userId, driversSelection: newRaceBet.driversSelection)
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
        return (raceBet, errorMessage)
    }
}

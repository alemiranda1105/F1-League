//
//  RaceResultRepositoryImpl.swift
//  F1 League
//
//  Created by Alejandro Miranda on 24/5/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class RaceResultRepositoryImpl: RaceResultRepository {
    private let raceResultDb = Firestore.firestore()
    
    func getRaceResults(race: Int) async -> (result: RaceResult?, errorMessage: String) {
        var raceResult: RaceResult? = nil
        var errorMessage = ""
        
        let ref = raceResultDb.collection(FirestoreDocuments.RACE_RESULTS.rawValue)
        do {
            let snapshot = try await ref.whereField("race", isEqualTo: race).getDocuments()
            if let firstDocument = snapshot.documents.first {
                raceResult = try firstDocument.data(as: RaceResult.self)
            }
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
        
        return (raceResult, errorMessage)
    }
    
    
}

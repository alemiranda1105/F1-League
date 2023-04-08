//
//  DriverRepositoryImpl.swift
//  F1 League
//
//  Created by Alejandro Miranda on 8/4/23.
//

import Foundation
import FirebaseFirestore

class DriverRepositoryImpl: DriverRepository {
    private let driversDb = Firestore.firestore()
    
    func getAllDrivers() async -> ([Driver], String) {
        var drivers = [Driver]()
        var errorMessage = ""
        
        let ref = driversDb.collection(FirestoreDocuments.DRIVERS.rawValue)
        do {
            let snapshot = try await ref.getDocuments()
            try snapshot.documents.forEach { document in
                let driver =  try document.data(as: Driver.self)
                drivers.append(driver)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        return (drivers, errorMessage)
    }
    
}

//
//  DriversService.swift
//  porra f1
//
//  Created by Alejandro Miranda on 25/3/23.
//

import Foundation
import FirebaseFirestore

class DriversService: ObservableObject {
    @Published var error: String?
    
    private let driversDb = Firestore.firestore()
    
    func getAllDrivers() async -> ([Driver], String?) {
        var drivers = [Driver]()
        let ref = driversDb.collection("drivers")
        do {
            let snapshot = try await ref.getDocuments()
            try snapshot.documents.forEach { document in
                let driver =  try document.data(as: Driver.self)
                drivers.append(driver)
            }
        } catch {
            self.error = error.localizedDescription
        }
        return (drivers, error)
    }
}

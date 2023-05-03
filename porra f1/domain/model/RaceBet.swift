//
//  RaceBet.swift
//  F1 League
//
//  Created by Alejandro Miranda on 15/4/23.
//

import Foundation
import FirebaseFirestoreSwift

struct RaceBet: Codable {
    @DocumentID var id: String?
    let betGroup: String
    let raceRound: String
    let userId: String
    let driversSelection: DriverSelection
}

struct DriverSelection: Codable {
    let winner: String
    let second: String
    let third: String
    
    func isValid() -> Bool {
        let driverZero = "0"
        let differentDrivers = winner != second && winner != third && second != third
        let areNotZero = winner != driverZero || second != driverZero || third != driverZero
        return differentDrivers
    }
}

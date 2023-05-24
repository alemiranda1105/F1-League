//
//  RacePodium.swift
//  F1 League
//
//  Created by Alejandro Miranda on 24/5/23.
//

import Foundation

struct RacePodium: Codable {
    let winner: String
    let second: String
    let third: String
    
    func isValid() -> Bool {
        let driverZero = "0"
        let differentDrivers = winner != second && winner != third && second != third
        let areNotZero = winner != driverZero || second != driverZero || third != driverZero
        return differentDrivers && areNotZero
    }
}

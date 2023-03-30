//
//  Race.swift
//  porra f1
//
//  Created by Alejandro Miranda on 27/3/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Race: Codable {
    @DocumentID var id: String?
    let circuit: Circuit
    let firstPractice, secondPractice, thirdPractice, qualifying: RaceSession?
    let raceName, time, url, date: String
    let round, season: Int
    
    func getRaceName() -> String {
        return "\(String(self.round)). \(self.raceName)"
    }

}


struct Circuit: Codable {
    let location: CircuitLocation
    let circuitId, circuitName, url: String
}

struct CircuitLocation: Codable {
    let country, lat, locality, long: String
}

struct RaceSession: Codable {
    let date, time: String
}

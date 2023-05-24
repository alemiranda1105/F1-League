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
    let raceRound: Int
    let userId: String
    let driversSelection: RacePodium
}

//
//  RaceResult.swift
//  F1 League
//
//  Created by Alejandro Miranda on 24/5/23.
//

import Foundation
import FirebaseFirestoreSwift

struct RaceResult: Codable{
    @DocumentID var id: String?
    let race: Int
    let podium: RacePodium
}

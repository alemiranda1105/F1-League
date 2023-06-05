//
//  GroupStandings.swift
//  F1 League
//
//  Created by Alejandro Miranda on 4/6/23.
//

import Foundation
import FirebaseFirestoreSwift

struct GroupStandings: Codable {
    @DocumentID var documentId: String?
    let groupId: String
    let standings: Array<StandingsPosition>
}


struct StandingsPosition: Codable, Hashable {
    let points: Int
    let userEmail: String
}

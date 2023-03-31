//
//  BetGroup.swift
//  porra f1
//
//  Created by Alejandro Miranda on 30/3/23.
//

import Foundation
import FirebaseFirestoreSwift

struct BetGroup: Codable {
    @DocumentID var id: String?
    let name: String
    let users: [String]
}

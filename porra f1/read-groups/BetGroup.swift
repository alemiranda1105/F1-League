//
//  BetGroup.swift
//  porra f1
//
//  Created by Alejandro Miranda on 30/3/23.
//

import Foundation
import FirebaseFirestoreSwift

struct BetGroup {
    @DocumentID var id: String?
    let name: String
    let users: [AppUser]
}

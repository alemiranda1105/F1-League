//
//  NewGroupMember.swift
//  porra f1
//
//  Created by Alejandro Miranda on 31/3/23.
//

import Foundation
import FirebaseFirestoreSwift

struct NewGroupMember: Codable {
    @DocumentID var id: String?
    let email: String
    var isSelected: Bool = false
}

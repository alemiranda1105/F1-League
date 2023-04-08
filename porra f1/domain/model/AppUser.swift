//
//  AppUser.swift
//  porra f1
//
//  Created by Alejandro Miranda on 30/3/23.
//

import Foundation
import FirebaseFirestoreSwift

struct AppUser: Codable {
    @DocumentID var id: String?
    let email: String
    let username: String
}

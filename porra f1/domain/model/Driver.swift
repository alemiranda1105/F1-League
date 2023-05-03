//
//  Driver.swift
//  porra f1
//
//  Created by Alejandro Miranda on 25/3/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Driver: Codable {
    @DocumentID var id: String?
    let code, dateOfBirth, driverId, familyName, givenName, nationality, permanentNumber, url: String
    
    func getRaceName() -> String {
        return "\(permanentNumber) \(familyName), \(givenName)"
    }
}

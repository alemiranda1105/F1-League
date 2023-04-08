//
//  RaceRepository.swift
//  F1 League
//
//  Created by Alejandro Miranda on 8/4/23.
//

import Foundation
import FirebaseFirestore

protocol RaceRepository {
    
    func getAllRaces() async -> (races: [Race], errorMessage: String)
    
}

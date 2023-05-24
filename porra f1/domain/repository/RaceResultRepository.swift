//
//  RaceResultRepository.swift
//  F1 League
//
//  Created by Alejandro Miranda on 24/5/23.
//

import Foundation

protocol RaceResultRepository {
    
    func getRaceResults(race: Int) async -> (result: RaceResult?, errorMessage: String)
    
}

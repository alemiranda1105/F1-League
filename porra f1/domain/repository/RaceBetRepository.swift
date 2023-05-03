//
//  RaceBetRepository.swift
//  F1 League
//
//  Created by Alejandro Miranda on 27/4/23.
//

import Foundation

protocol RaceBetRepository {
    func saveRaceBet(newRaceBet: RaceBet) async -> (RaceBet?, String)
}

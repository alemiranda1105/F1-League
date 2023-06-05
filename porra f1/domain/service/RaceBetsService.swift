//
//  RaceBetsService.swift
//  F1 League
//
//  Created by Alejandro Miranda on 27/4/23.
//

import Foundation

class RaceBetsService {
    let raceBetRepository: RaceBetRepository

    init(raceBetRepository: RaceBetRepository) {
        self.raceBetRepository = raceBetRepository
    }
    
    func saveRaceBet(newRaceBet: RaceBet) async -> (raceBet: RaceBet?, error: String) {
        return await self.raceBetRepository.saveRaceBet(newRaceBet: newRaceBet)
    }
    
    func loadBetByRaceAndUser(userEmail: String, groupId: String, raceRound: Int) async -> (userBet: RaceBet?, error: String) {
        return await self.raceBetRepository.loadBetByRaceAndUser(userEmail: userEmail, groupId: groupId, raceRound: raceRound)
    }
}

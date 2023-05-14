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
    
    func loadBetByRaceAndUser(userId: String, groupId: String, raceRound: Int) async -> (userBet: RaceBet?, error: String) {
        return await self.raceBetRepository.loadBetByRaceAndUser(userId: userId, groupId: groupId, raceRound: raceRound)
    }
}

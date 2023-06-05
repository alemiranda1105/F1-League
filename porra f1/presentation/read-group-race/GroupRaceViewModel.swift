//
//  GroupRaceViewModel.swift
//  F1 League
//
//  Created by Alejandro Miranda on 9/4/23.
//

import Foundation

@MainActor class GroupRaceViewModel: ObservableObject {
    private let raceService = RacesService()
    private let raceBetsService = RaceBetsService(raceBetRepository: RaceBetImpl())
    
    @Published var race: Race?
    @Published var error = ""
    @Published var loading = true
    @Published var userBet: RaceBet?
    @Published var raceResult: RaceResult?
    
    
    func readRaceDetails(round: Int) async {
        self.loading = true
        (self.race, self.error) = await raceService.getRaceByRound(round: round)
        self.loading = false
    }
    
    func loadUserBet(userEmal: String, groupId: String, raceRound: Int) async {
        self.loading = true
        (self.userBet, self.error) = await raceBetsService.loadBetByRaceAndUser(userEmail: userEmal, groupId: groupId, raceRound: raceRound)
        self.loading = false
    }
    
    func loadRaceResults(raceRound: Int) async {
        self.loading = true
        (self.raceResult, self.error) = await raceService.loadRaceResults(round: raceRound)
        self.loading = false
    }
}

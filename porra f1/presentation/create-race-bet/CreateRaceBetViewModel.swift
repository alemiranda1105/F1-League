//
//  CreateRaceBetViewModel.swift
//  F1 League
//
//  Created by Alejandro Miranda on 15/4/23.
//

import Foundation

@MainActor class CreateRaceBetViewModel: ObservableObject {
    private let driversService = DriversService()
    private let raceBetsService = RaceBetsService(raceBetRepository: RaceBetImpl())
    
    @Published var drivers = [Driver]()
    @Published var errorMessage = ""
    @Published var pending = true
    @Published var submitted = false
    
    init(drivers: [Driver] = [Driver](), errorMessage: String = "", pending: Bool = true, submitted: Bool = false) {
        self.drivers = drivers
        self.errorMessage = errorMessage
        self.pending = pending
        self.submitted = submitted
    }
    
    func loadDrivers() async {
        self.pending = true
        (self.drivers, self.errorMessage) = await driversService.getAllDrivers()
        self.pending = false
    }
    
    func createBet(betGroup: String, raceRound: Int, userEmail: String, winner: String, second: String, third: String) async {
        self.pending = true
        self.errorMessage = ""
        let raceBet = RaceBet(betGroup: betGroup, raceRound: raceRound, userEmail: userEmail, driversSelection: RacePodium(winner: winner, second: second, third: third))
        guard raceBet.driversSelection.isValid() else {
            self.errorMessage = "bet-not-valid"
            self.pending = false
            return
        }
        
        let creationResult = await self.raceBetsService.saveRaceBet(newRaceBet: raceBet)
        guard creationResult.error.isEmpty else {
            self.errorMessage = creationResult.error
            self.pending = true
            return
        }
        self.pending = false
        self.submitted = true
    }
    
}

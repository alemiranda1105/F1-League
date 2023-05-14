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
    @Published var submitted = true
    
    func loadDrivers() async {
        self.pending = true
        (self.drivers, self.errorMessage) = await driversService.getAllDrivers()
        self.pending = false
    }
    
    func createBet(betGroup: String, raceRound: Int, userId: String, winner: String, second: String, third: String) async {
        self.pending = true
        self.errorMessage = ""
        let raceBet = RaceBet(betGroup: betGroup, raceRound: "\(raceRound)", userId: userId, driversSelection: DriverSelection(winner: winner, second: second, third: third))
        if !raceBet.driversSelection.isValid() {
            self.errorMessage = "bet-not-valid"
            self.pending = false
            return
        }
        self.pending = false
    }
    
    private func validateBet(raceBet: RaceBet) -> Bool {
        return raceBet.driversSelection.isValid()
    }
    
}

//
//  GroupRaceViewModel.swift
//  F1 League
//
//  Created by Alejandro Miranda on 9/4/23.
//

import Foundation

@MainActor class GroupRaceViewModel: ObservableObject {
    private let raceService = RacesService()
    
    @Published var race: Race?
    @Published var error = ""
    @Published var loading = true
    
    
    func readRaceDetails(round: Int) async {
        self.loading = true
        (self.race, self.error) = await raceService.getRaceByRound(round: round)
        self.loading = false
    }
}

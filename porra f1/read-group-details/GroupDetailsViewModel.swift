//
//  GroupDetailsViewModel.swift
//  porra f1
//
//  Created by Alejandro Miranda on 4/4/23.
//

import Foundation

@MainActor class GroupDetailsViewModel: ObservableObject {
    private var racesService = RacesService()
    
    @Published var races: [Race]
    @Published var pending: Bool
    @Published var error: String
    
    init(races: [Race] = [], pending: Bool = true, error: String = "") {
        self.races = races
        self.pending = pending
        self.error = error
    }

    
    func loadAllRaces() async {
        self.pending = true
        (self.races, self.error) = await racesService.getAllRaces()
        self.pending = false 
    }
}

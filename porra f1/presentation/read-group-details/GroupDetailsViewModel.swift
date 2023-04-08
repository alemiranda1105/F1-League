//
//  GroupDetailsViewModel.swift
//  porra f1
//
//  Created by Alejandro Miranda on 4/4/23.
//

import Foundation

@MainActor class GroupDetailsViewModel: ObservableObject {
    private let racesService = RacesService()
    
    @Published var currentRace: Race? = nil
    @Published var nextRaces: [Race] = []
    @Published var prevRaces: [Race] = []
    @Published var pending: Bool = true
    @Published var error: String = ""

    
    func loadAllRaces() async {
        self.pending = true
        let (races, error) = await racesService.getAllRaces()
        
        self.error = error
        if error.isEmpty {
            let now = Date()
            self.nextRaces = races.filter({ $0.getRaceDatetime() >= now })
            self.prevRaces = races.filter({ $0.getRaceDatetime() < now })
            
            self.currentRace = self.nextRaces.removeFirst()
        }
        
        self.pending = false 
    }
}

//
//  RacesService.swift
//  porra f1
//
//  Created by Alejandro Miranda on 27/3/23.
//

import Foundation
import FirebaseFirestore

class RacesService {
    private let racesRepository = RaceRepositoryImpl()
    private let raceResultRepository = RaceResultRepositoryImpl()
    
    func getAllRaces() async -> ([Race], String) {
        var (races, errorMessage) = await racesRepository.getAllRaces()
        
        if !races.isEmpty {
            races = races.sorted { $0.round < $1.round }
        }
        
        return (races, errorMessage)
    }
    
    func getRaceByRound(round: Int) async -> (race: Race?, errorMessage: String) {
        return await racesRepository.getRaceByRound(round: round)
    }
    
    func loadRaceResults(round: Int) async -> (result: RaceResult?, errorMessage: String) {
        return await raceResultRepository.getRaceResults(race: round)
    }
}

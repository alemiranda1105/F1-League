//
//  GroupStandingsService.swift
//  F1 League
//
//  Created by Alejandro Miranda on 4/6/23.
//

import Foundation

class GroupStandingsService {
    let groupStandingsRepository: GroupStandingsRepository
    
    init(groupStandingsRepository: GroupStandingsRepository) {
        self.groupStandingsRepository = groupStandingsRepository
    }
    
    func loadStandings(groupId: String) async -> (groupStandings: GroupStandings?, error: String) {
        return await self.groupStandingsRepository.loadGroupStandings(groupId: groupId)
    }
}

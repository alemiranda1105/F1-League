//
//  GroupStandingsViewModel.swift
//  F1 League
//
//  Created by Alejandro Miranda on 4/6/23.
//

import Foundation

@MainActor class GroupStandingsViewModel: ObservableObject {
    let groupStandingsService = GroupStandingsService(groupStandingsRepository: GroupStandingsRepositoryImpl())
    
    @Published var pending = true
    @Published var error = ""
    @Published var standings: GroupStandings? = nil
    
    func loadStandings(groupId: String) async {
        self.pending = true
        (standings, error) = await self.groupStandingsService.loadStandings(groupId: groupId)
        if standings != nil {
            sortStandings()
        }
        self.pending = false
    }
    
    private func sortStandings() {
        var standings = self.standings!.standings
        standings.sort(by: { $0.points >= $1.points })
        self.standings = GroupStandings(documentId: self.standings!.documentId, groupId: self.standings!.groupId, standings: standings)
    }
    
}

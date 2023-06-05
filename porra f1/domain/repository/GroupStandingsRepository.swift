//
//  GroupStandingsRepository.swift
//  F1 League
//
//  Created by Alejandro Miranda on 4/6/23.
//

import Foundation

protocol GroupStandingsRepository {
    func loadGroupStandings(groupId: String) async -> (groupStandings: GroupStandings?, error: String)
}

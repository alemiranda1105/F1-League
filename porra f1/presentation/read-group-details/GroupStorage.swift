//
//  GroupStorage.swift
//  F1 League
//
//  Created by Alejandro Miranda on 11/5/23.
//

import Foundation

class GroupStorage: ObservableObject {
    @Published var userId = ""
    @Published var groupId = ""
    
    init(groupId: String, userId: String) {
        self.groupId = groupId
        self.userId = userId
    }
}

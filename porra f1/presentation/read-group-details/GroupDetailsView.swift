//
//  GroupDetailsView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 4/4/23.
//

import SwiftUI

struct GroupDetailsView: View {
    @StateObject var groupDetailsVm = GroupDetailsViewModel()
    @Binding var group: BetGroup
    
    @State private var showAllNextRaces = false
    @State private var showAllPrevRaces = false
    private var currentRace: Binding<Race> {
        Binding<Race>(
            get: {
                // it won't be nil
                groupDetailsVm.currentRace!
            },
            set: { newValue in
                groupDetailsVm.currentRace = newValue
            }
        )
    }
    
    private func loadRaces() {
        Task {
            await groupDetailsVm.loadAllRaces()
        }
    }
    
    var body: some View {
        VStack {
            if groupDetailsVm.pending {
                ProgressView() {
                    Text("loading-text")
                }
            } else if !groupDetailsVm.error.isEmpty {
                Text(groupDetailsVm.error)
            } else {
                GroupRacesView(currentRace: currentRace, nextRaces: $groupDetailsVm.nextRaces, prevRaces: $groupDetailsVm.prevRaces)
            }
        }
        .navigationTitle(group.name)
        .onAppear {
            loadRaces()
        }
        .refreshable {
            loadRaces()
        }
        
    }
}

struct GroupDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        GroupDetailsView(group: .constant(BetGroup(id: "1", name: "Test 1", users: ["test1@test.com", "test2@test.com", "test3@test.com"])))
    }
}

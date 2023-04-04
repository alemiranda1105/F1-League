//
//  GroupDetailsView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 4/4/23.
//

import SwiftUI

struct GroupDetailsView: View {
    @ObservedObject var groupDetailsVm = GroupDetailsViewModel()
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
        NavigationStack {
            Group {
                if groupDetailsVm.pending {
                    ProgressView() {
                        Text("loading-text")
                    }
                } else if !groupDetailsVm.error.isEmpty {
                    Text(groupDetailsVm.error)
                } else {
                    Form {
                        if groupDetailsVm.currentRace != nil {
                            Section {
                                GroupRaceListItem(race: currentRace)
                            } header: {
                                Text("current-race-text")
                            }
                            .headerProminence(.increased)
                        }
                        
                        Section {
                            if showAllNextRaces {
                                List($groupDetailsVm.nextRaces, id: \.id) { $race in
                                    GroupRaceListItem(race: $race)
                                }
                            } else {
                                GroupRaceListItem(race: $groupDetailsVm.nextRaces.first!)
                            }
                            Button {
                                withAnimation {
                                    showAllNextRaces.toggle()
                                }
                            } label: {
                                HStack {
                                    Image(systemName: showAllNextRaces ? "chevron.up" : "chevron.down")
                                    Text(showAllNextRaces ? "hide-next-races-text" : "show-next-races-text")
                                }
                            }
                        } header: {
                            Text("next-races-text")
                        }
                        
                        Section {
                            if showAllPrevRaces {
                                List($groupDetailsVm.prevRaces, id: \.id) { $race in
                                    GroupRaceListItem(race: $race)
                                }
                            } else {
                                GroupRaceListItem(race: $groupDetailsVm.prevRaces.first!)
                            }
                            Button {
                                withAnimation {
                                    showAllPrevRaces.toggle()
                                }
                            } label: {
                                HStack {
                                    Image(systemName: showAllPrevRaces ? "chevron.up" : "chevron.down")
                                    Text(showAllPrevRaces ? "hide-prev-races-text" : "show-prev-races-text")
                                }
                            }
                        } header: {
                            Text("prev-races-text")
                        }
                    }
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
}

struct GroupDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        GroupDetailsView(group: .constant(BetGroup(id: "1", name: "Test 1", users: ["test1@test.com", "test2@test.com", "test3@test.com"])))
    }
}

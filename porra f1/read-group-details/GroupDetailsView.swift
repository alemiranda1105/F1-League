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
                    List($groupDetailsVm.races, id: \.id) { $race in
                        GroupRaceListItem(race: $race)
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
        GroupDetailsView(groupDetailsVm: GroupDetailsViewModel(races: [
            Race(
                id: "1",
                circuit: Circuit(
                    location: CircuitLocation(country: "Spain", lat: "22", locality: "22", long: "22"),
                    circuitId: "1",
                    circuitName: "Test Circuit",
                    url: "http://en.wikipedia.org/wiki/Silverstone_Circuit"
                ),
                firstPractice: RaceSession(date: "11-11-1111", time: "21:01Z"),
                secondPractice: RaceSession(date: "11-11-1111", time: "21:01Z"),
                thirdPractice: RaceSession(date: "11-11-1111", time: "21:01Z"),
                qualifying: RaceSession(date: "11-11-1111", time: "21:01Z"),
                raceName: "Test GP",
                time: "19;19;0Z",
                url: "",
                date: "2023-10-10",
                round: 1,
                season: 2023
            ),
            Race(
                id: "2",
                circuit: Circuit(
                    location: CircuitLocation(country: "Spain", lat: "22", locality: "22", long: "22"),
                    circuitId: "1",
                    circuitName: "Test Circuit",
                    url: "http://en.wikipedia.org/wiki/Silverstone_Circuit"
                ),
                firstPractice: RaceSession(date: "11-11-1111", time: "21:01Z"),
                secondPractice: RaceSession(date: "11-11-1111", time: "21:01Z"),
                thirdPractice: RaceSession(date: "11-11-1111", time: "21:01Z"),
                qualifying: RaceSession(date: "11-11-1111", time: "21:01Z"),
                raceName: "Test GP",
                time: "19;19;0Z",
                url: "",
                date: "2023-10-10",
                round: 2    ,
                season: 2023
            )
        ], pending: false, error: ""), group: .constant(BetGroup(id: "1", name: "Test 1", users: ["test1@test.com", "test2@test.com", "test3@test.com"])))
    }
}

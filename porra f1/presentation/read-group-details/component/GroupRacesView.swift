//
//  GroupRacesView.swift
//  F1 League
//
//  Created by Alejandro Miranda on 9/4/23.
//

import SwiftUI

struct GroupRacesView: View {    
    @Binding var currentRace: Race
    @Binding var nextRaces: [Race]
    @Binding var prevRaces: [Race]
    
    @State var showAllNextRaces = false
    @State var showAllPrevRaces = false
    
    var body: some View {
        Form {
            CurrentRaceView(currentRace: $currentRace)
            
            Section {
                ExpandableRacesListView(races: $nextRaces, headerText: "next-races-text", showAll: $showAllNextRaces)
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
                ExpandableRacesListView(races: $prevRaces, headerText: "prev-races-text", showAll: $showAllPrevRaces)
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

struct GroupRacesView_Previews: PreviewProvider {
    static var previews: some View {
        GroupRacesView(
            currentRace: .constant(Race(
                id: "1",
                circuit: Circuit(
                    location: CircuitLocation(country: "Spain", lat: "22", locality: "22", long: "22"),
                    circuitId: "1",
                    circuitName: "Test Circuit",
                    url: "http://en.wikipedia.org/wiki/Silverstone_Circuit"
                ),
                firstPractice: RaceSession(date: "11-11-1111", time: "21:01Z"),
                secondPractice: RaceSession(date: "11-11-1111", time: "21:01Z"),
                qualifying: RaceSession(date: "11-11-1111", time: "21:01Z"), thirdPractice: RaceSession(date: "11-11-1111", time: "21:01Z"),
                sprint: nil,
                raceName: "Test GP",
                time: "19;19;0Z",
                url: "",
                date: "2023-10-10",
                round: 1,
                season: 2023
            )),
            nextRaces: .constant([Race]()),
            prevRaces: .constant([Race]()))
    }
}

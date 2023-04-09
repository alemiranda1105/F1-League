//
//  CurrentRaceView.swift
//  F1 League
//
//  Created by Alejandro Miranda on 9/4/23.
//

import SwiftUI

struct CurrentRaceView: View {
    @Binding var currentRace: Race
    
    var body: some View {
        Section {
            GroupRaceListItem(race: $currentRace)
        } header: {
            Text("current-race-text")
        }
        .headerProminence(.increased)
    }
}

struct CurrentRaceView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentRaceView(currentRace: .constant(Race(
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
        )))
    }
}

//
//  GroupRaceListItem.swift
//  porra f1
//
//  Created by Alejandro Miranda on 4/4/23.
//

import SwiftUI

struct GroupRaceListItem: View {
    
    @Binding var race: Race
    
    var body: some View {
        NavigationLink(destination: {}) {
            HStack(spacing: 30) {
                Image("GP-\(race.round)")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(race.round). \(race.raceName)")
                        .font(.system(size: 20, weight: .bold))
                    
                    Text(race.circuit.circuitName)
                        .font(.system(size: 18, weight: .light))
                    
                    Text("\(race.date)")
                }
                
            }
        }
    }
}

struct GroupRaceListItem_Previews: PreviewProvider {
    static var previews: some View {
        GroupRaceListItem(race: .constant(Race(
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

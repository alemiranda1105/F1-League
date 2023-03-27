//
//  RacesListItemView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 27/3/23.
//

import SwiftUI

struct RacesListItemView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var race: Race
    
    private let CORNER_RADIUS: CGFloat = 10
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Image(String(race.round))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(race.round). \(race.raceName)")
                        .font(.system(size: 20, weight: .bold))
                    
                    Text(race.circuit.circuitName)
                        .font(.system(size: 18, weight: .light))
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 10) {
                    Text("\(race.date)")
                    Text("\(race.time)")
                }
            }
            .padding()
            
        }
        .frame(maxWidth: .infinity)
        .background(colorScheme == .dark ? Color.gray.opacity(0.2) : Color.gray.opacity(0.1))
        .cornerRadius(CORNER_RADIUS)
        .padding()
        
    }
}

struct RacesListItemView_Previews: PreviewProvider {
    static var previews: some View {
        RacesListItemView(race:
                .constant(
                    Race(
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
                    )
                )
        )
        
        RacesListItemView(race:
                .constant(
                    Race(
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
                    )
                )
        ).colorScheme(.dark)
    }
}

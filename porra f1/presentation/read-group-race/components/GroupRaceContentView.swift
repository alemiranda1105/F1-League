//
//  GroupRaceContentView.swift
//  F1 League
//
//  Created by Alejandro Miranda on 15/4/23.
//

import SwiftUI

struct GroupRaceContentView: View {
    @Environment(\.colorScheme) var colorScheme
    let race: Race
    
    @State var showMore = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Image("GP-\(race.round)")
                .resizable()
                .scaledToFit()
            
            VStack(alignment: .leading) {
                Text("\(race.getRaceName())")
                    .font(.system(size: 20, weight: .bold))
                
                Text(race.circuit.circuitName)
                    .font(.system(size: 18, weight: .light))
                
                Text("\(formatDate(race.getRaceDatetime()))")
                    .padding(.vertical, 2)
                
                Button {
                    withAnimation(.easeOut) {
                        showMore.toggle()
                    }
                } label: {
                    HStack {
                        Image(systemName: showMore ? "chevron.up" : "chevron.down")
                        Text(showMore ? "view-less-text" : "view-more-text")
                    }
                }
                
                if showMore {
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading) {
                            Text("FP1")
                                .bold()
                            Text("\(formatDate(race.firstPractice.getRaceSessionDatetime()))")
                        }
                        VStack(alignment: .leading) {
                            Text("FP2")
                                .bold()
                            Text("\(formatDate(race.secondPractice.getRaceSessionDatetime()))")
                        }
                        VStack(alignment: .leading) {
                            if race.thirdPractice != nil {
                                Text("FP3")
                                    .bold()
                                Text("\(formatDate(race.thirdPractice!.getRaceSessionDatetime()))")
                            } else if race.sprint != nil {
                                Text("Sprint")
                                    .bold()
                                Text("\(formatDate(race.sprint!.getRaceSessionDatetime()))")
                            }
                        }
                        VStack(alignment: .leading) {
                            Text("Q")
                                .bold()
                            Text("\(formatDate(race.qualifying.getRaceSessionDatetime()))")
                        }
                    }
                    .padding(.vertical)
                }
                
            }
            .padding()
        }
        .cornerRadius(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("CardColor"))
                .shadow(
                    color: colorScheme == .dark ? Color.white.opacity(0.15) : Color.black.opacity(0.15),
                    radius: 10,
                    x: 0,
                    y: 0
                )
        )
        .padding()
        
    }
}

struct GroupRaceContentView_Previews: PreviewProvider {
    static var previews: some View {
        GroupRaceContentView(race: Race(
            circuit: Circuit(
                location: CircuitLocation(country: "Spain", lat: "22", locality: "22", long: "22"),
                circuitId: "1",
                circuitName: "Test Circuit",
                url: "http://en.wikipedia.org/wiki/Silverstone_Circuit"
            ),
            firstPractice: RaceSession(date: "2023-10-10", time: "17:00:00Z"),
            secondPractice: RaceSession(date: "2023-10-10", time: "17:00:00Z"),
            qualifying: RaceSession(date: "2023-10-10", time: "17:00:00Z"), thirdPractice: RaceSession(date: "2023-10-10", time: "17:00:00Z"),
            sprint: nil, raceName: "Test GP",
            time: "17:00:00Z",
            url: "",
            date: "2023-10-10",
            round: 1,
            season: 2023
        ), showMore: true)
    }
}

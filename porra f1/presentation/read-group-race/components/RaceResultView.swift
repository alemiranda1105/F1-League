//
//  RaceResultView.swift
//  F1 League
//
//  Created by Alejandro Miranda on 24/5/23.
//

import SwiftUI

struct RaceResultView: View {
    @Environment(\.colorScheme) var colorScheme
    var raceResult: RaceResult
    
    var body: some View {
        VStack {
            Text("race-result-texts")
                .font(.system(.title2))
            HStack {
                VStack {
                    Text("Second")
                    Image("DRIVER-\(raceResult.podium.second)")
                    Text(raceResult.podium.second)
                        .bold()
                }
                .padding()
                .background(Color("CardColor"))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("SecondSilver"), lineWidth: 4)
                )
                
                Spacer()
                
                VStack {
                    Text("Winner")
                    Image("DRIVER-\(raceResult.podium.winner)")
                    Text(raceResult.podium.winner)
                        .bold()
                }
                .padding()
                .background(Color("CardColor"))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("WinnerGold"), lineWidth: 4)
                )
                
                Spacer()
                
                VStack {
                    Text("Third")
                    Image("DRIVER-\(raceResult.podium.third)")
                    Text(raceResult.podium.third)
                        .bold()
                }
                .padding()
                .background(Color("CardColor"))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("ThirdBronze"), lineWidth: 4)
                )
            }
        }
        .padding()
        .background(colorScheme == .dark ? Color.gray.opacity(0.2) : Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding()
    }
}

struct RaceResultView_Previews: PreviewProvider {
    static var previews: some View {
        RaceResultView(raceResult: RaceResult(race: 1, podium: RacePodium(winner: "1", second: "11", third: "14")))
    }
}

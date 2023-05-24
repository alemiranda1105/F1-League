//
//  CurrentBetView.swift
//  F1 League
//
//  Created by Alejandro Miranda on 14/5/23.
//

import SwiftUI

struct CurrentBetView: View {
    @Environment(\.colorScheme) var colorScheme
    let currentBet: RaceBet
    
    var body: some View {
        VStack {
            Text("your-bet-texts")
                .font(.system(.title2))
            HStack {
                VStack {
                    Text("Second")
                    Image("DRIVER-\(currentBet.driversSelection.second)")
                    Text(currentBet.driversSelection.second)
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
                    Image("DRIVER-\(currentBet.driversSelection.winner)")
                    Text(currentBet.driversSelection.winner)
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
                    Image("DRIVER-\(currentBet.driversSelection.third)")
                    Text(currentBet.driversSelection.third)
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

struct CurrentBetView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentBetView(currentBet: RaceBet(betGroup: "1", raceRound: 1, userId: "1", driversSelection: RacePodium(winner: "14", second: "1", third: "55")))
        CurrentBetView(currentBet: RaceBet(betGroup: "1", raceRound: 1, userId: "1", driversSelection: RacePodium(winner: "14", second: "1", third: "55")))
            .preferredColorScheme(.dark)
    }
}

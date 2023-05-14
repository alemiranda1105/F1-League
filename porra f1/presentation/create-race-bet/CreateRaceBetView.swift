//
//  CreateRaceBetView.swift
//  F1 League
//
//  Created by Alejandro Miranda on 15/4/23.
//

import SwiftUI

struct CreateRaceBetView: View {
    @EnvironmentObject var groupStorage: GroupStorage
    @Binding var raceRound: Int
    
    private let DEFAULT_BET = "0"
    @ObservedObject private var createRaceBetViewModel = CreateRaceBetViewModel()
    @State private var winner = "0"
    @State private var second = "0"
    @State private var third = "0"
    
    func cleanBets() {
        winner = DEFAULT_BET
        second = DEFAULT_BET
        third = DEFAULT_BET
        createRaceBetViewModel.errorMessage = ""
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if createRaceBetViewModel.pending {
                    ProgressView() {
                        Text("loading-text")
                    }
                } else {
                    Form {
                        Section("select-drivers") {
                            DriverPickerView(drivers: createRaceBetViewModel.drivers, positionLabel: "winner", position: $winner)
                            DriverPickerView(drivers: createRaceBetViewModel.drivers, positionLabel: "second", position: $second)
                            DriverPickerView(drivers: createRaceBetViewModel.drivers, positionLabel: "third", position: $third)
                            Button {
                                cleanBets()
                            } label: {
                                Text("clean-bet")
                            }
                        }
                        
                        Section {
                            Button {
                                Task {
                                    await createRaceBetViewModel.createBet(betGroup: self.groupStorage.groupId, raceRound: self.raceRound, userId: self.groupStorage.userId, winner: winner, second: second, third: third)
                                }
                            } label: {
                                Text("create-bet-button")
                                    .bold()
                            }
                            
                            if !createRaceBetViewModel.errorMessage.isEmpty {
                                Text(createRaceBetViewModel.errorMessage)
                                    .foregroundColor(Color.accentColor)
                            }
                        }
                    }
                }
            }
            .navigationTitle("create-bet-title")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await createRaceBetViewModel.loadDrivers()
            }
        }
    }
}

struct CreateRaceBetView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRaceBetView(raceRound: .constant(1))
    }
}

//
//  GroupRaceView.swift
//  F1 League
//
//  Created by Alejandro Miranda on 9/4/23.
//

import SwiftUI

struct GroupRaceView: View {
    @ObservedObject var groupRaceViewModel = GroupRaceViewModel()

    let raceRound: Int
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Group {
                    if groupRaceViewModel.loading {
                        ProgressView("loading-text")
                    } else {
                        if !groupRaceViewModel.error.isEmpty {
                            Text(groupRaceViewModel.error)
                        } else {
                            VStack {
                                GroupRaceContentView(race: self.groupRaceViewModel.race!)
                                
                                if Date() <= groupRaceViewModel.race!.qualifying.getRaceSessionDatetime() {
                                    NavigationLink(destination: CreateRaceBetView()) {
                                        Text("create-bet")
                                    }
                                } else {
                                    Text("You cannot create a bet after the Qualy")
                                        .bold()
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(groupRaceViewModel.race?.getRaceName() ?? "")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            await groupRaceViewModel.readRaceDetails(round: raceRound)
        }
    }
}

struct GroupRaceView_Previews: PreviewProvider {
    static var previews: some View {
        GroupRaceView(raceRound: 1)
    }
}

//
//  GroupStandingsView.swift
//  F1 League
//
//  Created by Alejandro Miranda on 4/6/23.
//

import SwiftUI

struct GroupStandingsView: View {
    @StateObject var groupStndingsViewModel = GroupStandingsViewModel()
    
    @Binding var groupId: String
    
    var body: some View {
        Group {
            if groupStndingsViewModel.pending {
                ProgressView() {
                    Text("loading-text")
                }
            } else if !groupStndingsViewModel.error.isEmpty {
                Text(groupStndingsViewModel.error)
            } else {
                ScrollView {
                    ForEach(groupStndingsViewModel.standings!.standings, id: \.self) { position in
                        GroupStandingsPositionView(userEmail: .constant(position.userEmail), points: .constant(position.points))
                    }
                }
            }
        }
        .navigationTitle("standings-title")
        .onAppear {
            Task {
                await self.groupStndingsViewModel.loadStandings(groupId: groupId)
            }
        }
        .refreshable {
            Task {
                await self.groupStndingsViewModel.loadStandings(groupId: groupId)
            }
        }
    }
}

struct GroupStandingsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupStandingsView(groupId: .constant("1"))
    }
}

//
//  RacesView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 27/3/23.
//

import SwiftUI

struct RacesView: View {
    @ObservedObject private var racesService = RacesService()
    
    @State private var races = [Race]()
    @State private var error = ""
    @State private var pending = true
    
    private func loadRaces() {
        Task {
            self.pending = true
            (self.races, self.error) = await racesService.getAllRaces()
            self.pending = false
        }
    }
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 15) {
                    if pending {
                        ProgressView() {
                            Text("loading-text")
                        }
                    } else if !races.isEmpty && error.isEmpty {
                        ForEach($races, id: \.id) { race in
                            RacesListItemView(race: race)
                        }
                    } else if !error.isEmpty {
                        Text(error)
                    }
                }
            }
            .navigationTitle("races-view")
            .refreshable {
                loadRaces()
            }
            .onAppear {
                loadRaces()
            }
        }
    }
}

struct RacesView_Previews: PreviewProvider {
    static var previews: some View {
        RacesView()
    }
}

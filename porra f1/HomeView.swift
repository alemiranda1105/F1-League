//
//  HomeView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 25/3/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            BetView()
                .tabItem {
                    Label("groups-view", systemImage: "person.3")
                }
            DriversView()
                .tabItem {
                    Label("drivers-view", systemImage: "steeringwheel")
                }
            RacesView()
                .tabItem {
                    Label("races-view", systemImage: "road.lanes.curved.left")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

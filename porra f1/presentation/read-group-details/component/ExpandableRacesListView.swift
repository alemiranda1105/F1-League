//
//  ExpandableRacesListView.swift
//  F1 League
//
//  Created by Alejandro Miranda on 9/4/23.
//

import SwiftUI

struct ExpandableRacesListView: View {
    @Binding var races: [Race]
    let headerText: String
    @Binding var showAll: Bool
    
    var body: some View {
        if showAll {
            List($races, id: \.id) { $race in
                GroupRaceListItem(race: $race)
            }
        } else {
            GroupRaceListItem(race: $races.first!)
        }
    }
}

struct ExpandableRacesListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandableRacesListView(races: .constant([Race]()), headerText: "Test", showAll: .constant(true))
    }
}

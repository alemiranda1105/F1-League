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
    
    
    @State var showAll = false
    
    var body: some View {
        Section {
            if showAll {
                List($races, id: \.id) { $race in
                    GroupRaceListItem(race: $race)
                }
            } else {
                GroupRaceListItem(race: $races.first!)
            }
            Button {
                withAnimation {
                    showAll.toggle()
                }
            } label: {
                HStack {
                    Image(systemName: showAll ? "chevron.up" : "chevron.down")
                    Text(showAll ? "hide-next-races-text" : "show-next-races-text")
                }
            }
        } header: {
            Text("\(headerText)")
        }
    }
}

struct ExpandableRacesListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandableRacesListView(races: .constant([Race]()), headerText: "Test")
    }
}

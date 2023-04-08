//
//  GroupList.swift
//  F1 League
//
//  Created by Alejandro Miranda on 8/4/23.
//

import SwiftUI

struct GroupList: View {
    @Binding var groups: [BetGroup]
    
    var body: some View {
        List($groups, id: \.id) { $group in
            NavigationLink(destination: GroupDetailsView(group: $group)) {
                Text(group.name)
                    .font(.system(size: 22, weight: .bold))
                    .padding(8)
            }
        }
    }
}

struct GroupList_Previews: PreviewProvider {
    static var previews: some View {
        GroupList(groups: .constant([BetGroup]()))
    }
}

//
//  GroupList.swift
//  F1 League
//
//  Created by Alejandro Miranda on 8/4/23.
//

import SwiftUI

struct GroupList: View {
    @EnvironmentObject var authStorage: AuthViewModel
    @Binding var groups: [BetGroup]
    
    var body: some View {
        List(groups, id: \.id) { group in
            NavigationLink(value: group) {
                Text(group.name)
                    .font(.system(size: 22, weight: .bold))
                    .padding(8)
            }
        }
        .navigationDestination(for: BetGroup.self) { group in
            GroupDetailsView(group: .constant(group))
                .environmentObject(GroupStorage(groupId: group.id!, userId: (authStorage.appUser?.id)!))
        }
    }
}

struct GroupList_Previews: PreviewProvider {
    static var previews: some View {
        GroupList(groups: .constant([BetGroup]()))
    }
}

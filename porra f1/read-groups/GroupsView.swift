//
//  GroupsView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 30/3/23.
//

import SwiftUI

struct GroupsView: View {
    private let appUserService = AppUserService()
    private let betGroupService = BetGroupsService()
    
    @State private var groups = [BetGroup]()
    @State private var error = ""
    @State private var pending = true
    
    @State private var showCreateGroupSheet = false
    
    private func loadGroups() async {
        self.pending = true
        guard let userEmail = await self.appUserService.getCurrentUser()?.email else {
            self.pending = false
            return
        }
        
        (self.groups, self.error) = await self.betGroupService.loadUserGroups(userEmail: userEmail)
        self.pending = false
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if pending {
                    ProgressView() {
                        Text("loading-text")
                    }
                } else {
                    if !error.isEmpty {
                        Text(error)
                    } else if groups.isEmpty {
                        VStack {
                            Text("no-groups-found")
                            Button {
                                showCreateGroupSheet = true
                            } label: {
                                Text("create-group")
                                    .bold()
                            }
                            .buttonStyle(.bordered)
                            .controlSize(.large)
                            .buttonBorderShape(.roundedRectangle(radius: 10))
                            
                            Spacer()
                        }
                        .padding()
                    } else {
                        List($groups, id: \.id) { $group in
                            NavigationLink(destination: GroupDetailsView(group: $group)) {
                                Text(group.name)
                                    .font(.system(size: 22, weight: .bold))
                                    .padding(8)
                            }
                        }
                    }
                }
            }
            .navigationTitle("groups-view")
            .task {
                await self.loadGroups()
            }
            .refreshable {
                Task {
                    await self.loadGroups()
                }
            }
            .sheet(isPresented: $showCreateGroupSheet, onDismiss: {
                self.showCreateGroupSheet = false
                Task {
                    await self.loadGroups()
                }
            }) {
                CreateGroupView(isSheet: true, showView: $showCreateGroupSheet)
            }
            
        }
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView()
    }
}

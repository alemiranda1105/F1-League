//
//  CreateGroupView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 31/3/23.
//

import SwiftUI

struct CreateGroupView: View {
    @EnvironmentObject private var authModel: AuthViewModel
    
    let isSheet: Bool
    @Binding var showView: Bool
    
    private let betGroupService = BetGroupsService()
    
    @State private var groupName = ""
    @State private var selectedUsers = [NewGroupMember]()
    @State private var error: String?
    
    private func createGroup() {
        var groupMembers: [String] = self.selectedUsers.map { $0.email }
        groupMembers.append(self.authModel.appUser!.email)
        let newGroup = BetGroup(name: self.groupName, users: groupMembers)
        let error = self.betGroupService.saveGroup(group: newGroup)
        
        if let error = error {
            self.error = error
        } else {
            self.showView = false
        }
    }
    
    private func disableSubmitButton() -> Bool {
        return self.groupName.isEmpty || self.selectedUsers.count < 1
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment:  .leading, spacing: 30) {
                VStack(alignment: .leading) {
                    Text("group-name-label")
                        .bold()
                    TextField("group-name-field", text: $groupName)
                        .modifier(LoginInputModifier())
                }
                
                
                VStack(alignment: .leading) {
                    Text("member-list")
                        .bold()
                    NavigationLink {
                        AddGroupMemberView(selectedUsers: $selectedUsers)
                    } label: {
                        Text("add-member-view")
                            .fontWeight(.light)
                    }
                }
                ScrollView {
                    LazyVStack {
                        ForEach(selectedUsers, id: \.email) { member in
                            Text(member.email)
                        }
                    }
                }
                
                Spacer()
                
                Button {
                    createGroup()
                } label: {
                    Text("create-group-button")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .buttonBorderShape(.roundedRectangle(radius: 10))
                .disabled(disableSubmitButton())
                
            }
            .padding()
            .navigationTitle("create-group")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isSheet {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("cancel-button") {
                            self.showView = false
                        }
                    }
                }
            }
        }
    }
}

struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroupView(isSheet: false, showView: .constant(true))
    }
}

//
//  AddGroupMemberView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 31/3/23.
//

import SwiftUI

struct AddGroupMemberView: View {
    @Environment(\.presentationMode) var presentationMode
    
    private let appUserService = AppUserService()
    
    @Binding var selectedUsers: [NewGroupMember]
    
    @State private var hasSearched = false
    @State private var userEmail: String = ""
    
    private func searchUser() {
        self.hasSearched = true
        Task {
            let usersResult = await self.appUserService.searchUsersByEmail(email: userEmail)
            self.selectedUsers.removeAll(where: { $0.isSelected == false })
            usersResult.forEach { user in
                self.selectedUsers.append(NewGroupMember(id: user.id, email: user.email, isSelected: false))
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if hasSearched && selectedUsers.isEmpty {
                    Text("not-users-found-text")
                        .bold()
                    Spacer()
                } else {
                    List($selectedUsers, id: \.email) { $result in
                        Button {
                            result.isSelected.toggle()
                        } label: {
                            HStack {
                                Text(result.email)
                                Spacer()
                                Image(systemName: result.isSelected ? "checkmark.circle.fill" : "checkmark.circle")
                            }
                        }
                    }
                    Button("save-members") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(self.selectedUsers.isEmpty)
                }
            }
            .searchable(text: $userEmail)
            .autocapitalization(.none)
            .navigationTitle("add-member-view")
            .onChange(of: userEmail) { newUserEmail in
                if userEmail.count > 2 {
                    searchUser()
                }
            }
        }
    }
}

struct AddGroupMemberView_Previews: PreviewProvider {
    static var previews: some View {
        AddGroupMemberView(selectedUsers: .constant([
            NewGroupMember(id: "1", email: "paco@test.com"),
            NewGroupMember(id: "2", email: "paco2@test.com"),
            NewGroupMember(id: "3", email: "paco3@test.com")
        ]))
        AddGroupMemberView(selectedUsers: .constant([NewGroupMember]()))
    }
}

//
//  EditUserView.swift
//  F1 League
//
//  Created by Alejandro Miranda on 6/6/23.
//

import SwiftUI

struct EditUserView: View {
    @EnvironmentObject var authStorage: AuthViewModel
    @Binding var currentUser: AppUser
    
    @StateObject var editUserViewModel = EditUserViewModel()
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("username")) {
                Text(currentUser.username)
                    .bold()
                TextField("new-username", text: $username)
                    .textInputAutocapitalization(.never)
            }
            
            Section(header: Text("email")) {
                Text(currentUser.email)
                    .bold()
                TextField("new-email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            
            Section {
                SecureInputView("password", text: $password)
                Button("submit") {
                    Task {
                        let newUsername = username.isEmpty ? currentUser.username : username
                        let newEmail = email.isEmpty ? currentUser.email : email
                        await self.editUserViewModel.updateUser(userId: currentUser.id!, newEmail: newEmail, newUsername: newUsername, password: password)
                        guard let user = self.editUserViewModel.authUser else {
                            return
                        }
                        self.authStorage.appUser = user
                    }
                }.disabled(password.isEmpty)
            }
        }
        .navigationTitle("edit-user-information")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EditUserView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserView(currentUser: .constant(AppUser(id: "1", email: "test@example.org", username: "test")))
    }
}

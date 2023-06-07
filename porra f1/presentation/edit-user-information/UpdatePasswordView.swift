//
//  UpdatePasswordView.swift
//  F1 League
//
//  Created by Alejandro Miranda on 7/6/23.
//

import SwiftUI

struct UpdatePasswordView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authStorage: AuthViewModel
    @Binding var currentUser: AppUser
    
    @StateObject var editUserViewModel = EditUserViewModel()
    @State private var oldPassword: String = ""
    @State private var newPassword: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("old-password")) {
                    SecureInputView("old-password", text: $oldPassword)
                        .textInputAutocapitalization(.never)
                }
                
                Section(header: Text("new-password")) {
                    SecureInputView("new-password", text: $newPassword)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    Button("submit") {
                        Task {
                            await self.editUserViewModel.updatePassword(email: currentUser.email, oldPassword: oldPassword, newPassword: newPassword)
                            if self.editUserViewModel.error.isEmpty {
                                dismiss()
                            }
                        }
                    }.disabled(oldPassword.isEmpty || newPassword.isEmpty)
                    
                    if !self.editUserViewModel.error.isEmpty {
                        Text(self.editUserViewModel.error)
                    }
                }
            }
            .navigationTitle("update-password")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("dismiss") {
                    dismiss()
                }
            }
        }
    }
}

struct UpdatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePasswordView(currentUser: .constant(AppUser(id: "1", email: "test@example.org", username: "test")))
    }
}

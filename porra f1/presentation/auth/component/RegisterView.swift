//
//  RegisterView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 13/3/23.
//

import SwiftUI

struct RegisterView: View {    
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    
    private func verifyFields() -> Bool {
        return !(email.isEmpty || password.isEmpty || username.isEmpty)
    }
    
    private func createAccount() async {
        if verifyFields() {
            await authViewModel.createAccount(emailAddress: email, password: password, username: username)
            self.errorMessage = authViewModel.errorMessage
        } else {
            self.errorMessage = "fields-not-verify-error"
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 35) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("username")
                    TextField("username", text: self.$username)
                        .modifier(LoginInputModifier())
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    
                    Text("email")
                    TextField("email", text: self.$email)
                        .modifier(LoginInputModifier())
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    
                    Text("password")
                    SecureInputView("password", text: self.$password)
                        .modifier(LoginInputModifier())
                        .cornerRadius(10)
                    
                    if !errorMessage.isEmpty {
                        Text(NSLocalizedString(errorMessage, comment: ""))
                            .foregroundColor(.red)
                            .bold()
                    }
                }
                
                Button {
                    Task {
                        await createAccount()
                    }
                } label: {
                    Text("create-account")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .buttonBorderShape(.roundedRectangle(radius: 10))
                .padding(.vertical, 35)
                .disabled(!verifyFields())
                Spacer()
            }
            .padding()
            .navigationTitle("login")
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

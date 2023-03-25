//
//  RegisterView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 13/3/23.
//

import SwiftUI

struct RegisterView: View {    
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    @State private var email = ""
    @State private var emailVerify = ""
    @State private var password = ""
    @State private var errorMessage = ""
    
    @State private var showPassword = false
    
    private func verifyEmail() -> Bool {
        return email == emailVerify
    }
    
    private func createAccount() async {
        if verifyEmail() {
            await authViewModel.signUp(emailAddress: email, password: password)
            if !authViewModel.errorMessage.isEmpty {
                self.errorMessage = authViewModel.errorMessage
            }
        } else {
            self.errorMessage = "email-not-verify-error"
        }
    }
    
    var body: some View {
        VStack(spacing: 25) {
            VStack {
                VStack(alignment: .leading, spacing: 15) {
                    Text("email")
                    TextField("email", text: self.$email)
                        .modifier(LoginInputModifier())
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    
                    Text("verify-email")
                    TextField("verify-email", text: self.$emailVerify)
                        .modifier(LoginInputModifier())
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                }
                VStack(alignment: .leading) {
                    Text("password")
                    SecureInputView("password", text: self.$password)
                        .modifier(LoginInputModifier())
                        .cornerRadius(10)
                }
                
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
            Spacer()
        }
        .padding()
        .navigationTitle("login")
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

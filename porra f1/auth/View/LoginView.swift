//
//  LoginView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 13/3/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""

    @State private var showPassword = false
    
    private func login() async {
        await authViewModel.signIn(email: email, password: password)
        if !authViewModel.errorMessage.isEmpty {
            self.errorMessage = authViewModel.errorMessage
        }
    }
    
    var body: some View {
        VStack(spacing: 25) {
            VStack {
                VStack(alignment: .leading) {
                    Text("email")
                    TextField("email", text: self.$email)
                        .modifier(LoginInputModifier())
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                }
                VStack(alignment: .leading)  {
                    Text("password")
                    SecureInputView("password", text: self.$password)
                        .modifier(LoginInputModifier())
                }
                if !errorMessage.isEmpty {
                    Text(NSLocalizedString(errorMessage, comment: ""))
                        .foregroundColor(.red)
                        .bold()
                }

            }
            Button {
                Task {
                    await login()
                }
            } label: {
                Text("login")
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

//
//  RegisterView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 13/3/23.
//

import SwiftUI

struct RegisterView: View {
    private enum FocusedField {
        case email, emailVerification, password
    }
    
    @State private var email = ""
    @State private var password = ""

    @State private var showPassword = false
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        VStack(spacing: 25) {
            VStack(alignment: .leading, spacing: 15) {
                Text("email")
                TextField("email", text: self.$email)
                    .modifier(LoginInputModifier())
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .focused($focusedField, equals: .email)
                
                Text("verify-email")
                TextField("verify-email", text: self.$email)
                    .modifier(LoginInputModifier())
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .focused($focusedField, equals: .emailVerification)
            }
            VStack(alignment: .leading)  {
                Text("password")
                SecureInputView("password", text: self.$password)
                    .modifier(LoginInputModifier())
                    .cornerRadius(10)
                    .focused($focusedField, equals: .password)
            }
            Button {
                // TODO: Add create account action
            } label: {
                Text("create-account")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .buttonBorderShape(.roundedRectangle(radius: 10))
            .padding(.vertical, 35)
            .onChange(of: focusedField) { newValue in
                if newValue == .email {
                    
                } else if newValue == .password {
                    
                } else {
                    
                }
            }
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

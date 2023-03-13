//
//  LoginView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 13/3/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

    @State private var showPassword = false
    
    var body: some View {
        VStack(spacing: 25) {
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
            Button {
                // TODO: Add login action
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

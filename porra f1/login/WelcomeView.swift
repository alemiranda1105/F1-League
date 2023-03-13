//
//  WelcomeView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 13/3/23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("welcome-message")
                Spacer()
                VStack {
                    NavigationLink {
                        LoginView()
                    } label: {
                        Text("login")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    
                    NavigationLink {
                        RegisterView()
                    } label: {
                        Text("sign-up")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                }
                .padding(20)
            }
            .navigationTitle("welcome")
            .frame(maxWidth: .infinity)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

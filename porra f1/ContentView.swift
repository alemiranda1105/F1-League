//
//  ContentView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 13/3/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authModel: AuthViewModel

    var body: some View {
        Group {
            if authModel.userIsSignedIn() {
                HomeView()
            } else {
                WelcomeView()
            }
        }
        .tint(Color("AccentColor"))
        .onAppear {
            authModel.listenToAuthState()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 13/3/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel

    var body: some View {
        Group {
            if authViewModel.authUser != nil {
                HomeView()
            } else {
                WelcomeView()
            }
        }
        .tint(Color("AccentColor"))
        .onAppear {
            authViewModel.listenToAuthState()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

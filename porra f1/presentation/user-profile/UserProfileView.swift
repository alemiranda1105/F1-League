//
//  UserProfileView.swift
//  F1 League
//
//  Created by Alejandro Miranda on 8/4/23.
//

import SwiftUI

struct UserProfileView: View {
    @ObservedObject var userProfileViewModel = UserProfileViewModel()
    @State private var showEditView = false
    @State private var showUpdatePasswordButton = false
    
    var body: some View {
        NavigationStack {
            Form {
                if userProfileViewModel.pending {
                    ProgressView("loading-text")
                }
                if userProfileViewModel.user != nil {
                    Section(header: Text("user-information")) {
                        Text(self.userProfileViewModel.user!.username)
                            .bold()
                        Text(self.userProfileViewModel.user!.email)
                            .bold()
                        /// TODO: Groups and bets use user email and not ID
                        // Button("edit-user-information") {
                        //     showEditView = true
                        // }
                        Button("update-password") {
                            showUpdatePasswordButton = true
                        }
                    }
                    
                    Section {
                        Button {
                            userProfileViewModel.signOut()
                        } label: {
                            Text("sign-out")
                        }
                    }
                }
            }
            .navigationTitle("profile-view")
        }
        .onAppear {
            Task {
                await self.userProfileViewModel.loadUser()
            }
        }
        .refreshable {
            Task {
                await self.userProfileViewModel.loadUser()
            }
        }
        .sheet(isPresented: $showUpdatePasswordButton) {
            if let currentUser = Binding($userProfileViewModel.user) {
                UpdatePasswordView(currentUser: currentUser)
            } else {
                Text("no-user-found")
            }
        }
        .sheet(isPresented: $showEditView) {
            if let currentUser = Binding($userProfileViewModel.user) {
                EditUserView(currentUser: currentUser)
            } else {
                Text("no-user-found")
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

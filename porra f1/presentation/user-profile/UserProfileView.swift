//
//  UserProfileView.swift
//  F1 League
//
//  Created by Alejandro Miranda on 8/4/23.
//

import SwiftUI

struct UserProfileView: View {
    @ObservedObject var userProfileViewModel = UserProfileViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Button {
                    userProfileViewModel.signOut()
                } label: {
                    Text("sign-out")
                }
            }
            .navigationTitle("profile-view")
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

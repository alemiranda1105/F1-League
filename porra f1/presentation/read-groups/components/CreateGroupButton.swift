//
//  CreateGroupButton.swift
//  F1 League
//
//  Created by Alejandro Miranda on 8/4/23.
//

import SwiftUI

struct CreateGroupButton: View {
    @Binding var showCreateGroupSheet: Bool
    
    var body: some View {
        Button {
            showCreateGroupSheet = true
        } label: {
            Text("create-group")
                .bold()
        }
        .buttonStyle(.bordered)
        .controlSize(.large)
        .buttonBorderShape(.roundedRectangle(radius: 10))
    }
}

struct CreateGroupButton_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroupButton(showCreateGroupSheet: .constant(false))
    }
}

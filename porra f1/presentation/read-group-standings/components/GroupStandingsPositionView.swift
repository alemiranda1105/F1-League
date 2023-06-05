//
//  GroupStandingsPositionView.swift
//  F1 League
//
//  Created by Alejandro Miranda on 4/6/23.
//

import SwiftUI

struct GroupStandingsPositionView: View {
    @Binding var userEmail: String
    @Binding var points: Int
    
    var body: some View {
        HStack {
            Text(userEmail)
                .bold()
            Spacer()
            Text("\(points)")
                .font(.system(size: 22, weight: .light))
        }
        .padding()
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(Color("CardColor"))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct GroupStandingsPositionView_Previews: PreviewProvider {
    static var previews: some View {
        GroupStandingsPositionView(userEmail: .constant("test@example.org"), points: .constant(14))
    }
}

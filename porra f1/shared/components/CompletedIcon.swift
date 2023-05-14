//
//  CompletedIcon.swift
//  F1 League
//
//  Created by Alejandro Miranda on 14/5/23.
//

import SwiftUI

struct CompletedIcon: View {
    @State private var rotateCheckMark = 90
    @State private var showCheckmark = -200
    
    var body: some View {
        Image(systemName: "checkmark")
            .resizable()
            .foregroundColor(.white)
            .padding()
            .frame(width: 80, height: 80)
            .padding()
            .background(Color.accentColor)
            .rotationEffect(.degrees(Double(rotateCheckMark)))
            .clipShape(Circle()
                .offset(x: CGFloat(showCheckmark))
            )
            .animation(.spring(response: 0.55, dampingFraction: 0.55, blendDuration: 0).delay(0.5), value: showCheckmark)
            //.animation(.interpolatingSpring(stiffness: 170, damping: 25).delay(2.0).repeatForever(), value: showCheckmark)
            .padding()
            .onAppear {
                rotateCheckMark = 0
                showCheckmark = 0
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            }
    }
}

struct CompletedIcon_Previews: PreviewProvider {
    static var previews: some View {
        CompletedIcon()
        CompletedIcon()
            .preferredColorScheme(.dark)
    }
}

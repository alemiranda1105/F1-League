//
//  DriversListItemView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 25/3/23.
//

import SwiftUI

struct DriversListItemView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var driver: Driver
    
    var body: some View {
        HStack (spacing: 30) {
            Image("DRIVER-\(driver.permanentNumber)")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
            
            Spacer()
            
            VStack(alignment: .center) {
                Text(driver.permanentNumber)
                    .font(.system(size: 32, weight: .heavy))
                Text("\(driver.givenName) \(driver.familyName)")
                    .font(.system(size: 24, weight: .bold))
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                
                Text(driver.nationality)
                    .font(.system(size: 20, weight: .light))
                
                Link(destination: URL(string: driver.url)!) {
                    Text("Wikipedia")
                }
            }
            .frame(maxWidth: .infinity)
            
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("CardColor"))
                .shadow(
                    color: colorScheme == .dark ? Color.white.opacity(0.15) : Color.black.opacity(0.15),
                    radius: 10,
                    x: 0,
                    y: 0
                )
        )
        .padding()
    }
}

struct DriversListItemView_Previews: PreviewProvider {
    static var previews: some View {
        DriversListItemView(driver: .constant(Driver(code: "MIR", dateOfBirth: "2000/05/11", driverId: "miranda", familyName: "Miranda", givenName: "Alejandro", nationality: "Spanish", permanentNumber: "33", url: "https://github.com/alemiranda1105")))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        
        DriversListItemView(driver: .constant(Driver(code: "MIR", dateOfBirth: "2000/05/11", driverId: "miranda", familyName: "Miranda", givenName: "Alejandro", nationality: "Spanish", permanentNumber: "21", url: "https://github.com/alemiranda1105")))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
    }
}

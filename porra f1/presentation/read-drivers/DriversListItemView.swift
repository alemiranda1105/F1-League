//
//  DriversListItemView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 25/3/23.
//

import SwiftUI

struct DriversListItemView: View {
    @Binding var driver: Driver
    
    var body: some View {
        HStack (spacing: 30) {
            VStack(alignment: .leading) {
                Text(driver.permanentNumber)
                    .font(.system(size: 32, weight: .heavy))
                Text(driver.code)
                    .font(.system(size: 24, weight: .bold))
            }
            
            VStack(alignment: .leading) {
                Text("\(driver.givenName) \(driver.familyName)")
                    .font(.system(size: 24, weight: .bold))
                    .lineLimit(2)
                Text(driver.nationality)
                    .font(.system(size: 20, weight: .light))
            }
            
            Spacer()
            
            Link(destination: URL(string: driver.url)!) {
                Image(systemName: "network")
            }
            
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("AccentColor") , lineWidth: 1)
        )
        .padding()
    }
}

struct DriversListItemView_Previews: PreviewProvider {
    static var previews: some View {
        DriversListItemView(driver: .constant(Driver(code: "MIR", dateOfBirth: "2000/05/11", driverId: "miranda", familyName: "Miranda", givenName: "Alejandro", nationality: "Spanish", permanentNumber: "21", url: "https://github.com/alemiranda1105")))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        
        DriversListItemView(driver: .constant(Driver(code: "MIR", dateOfBirth: "2000/05/11", driverId: "miranda", familyName: "Miranda", givenName: "Alejandro", nationality: "Spanish", permanentNumber: "21", url: "https://github.com/alemiranda1105")))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
    }
}

//
//  DriverPickerView.swift
//  F1 League
//
//  Created by Alejandro Miranda on 15/4/23.
//

import SwiftUI

struct DriverPickerView: View {
    let drivers: [Driver]
    let positionLabel: String
    
    @Binding var position: String
    
    var body: some View {
        Picker(LocalizedStringKey(positionLabel), selection: $position) {
            Text("nothing-selected").tag("0")
            ForEach(drivers, id: \.permanentNumber) { driver in
                Text(driver.getRaceName()).tag(driver.permanentNumber)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
}

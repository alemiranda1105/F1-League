//
//  DateUtils.swift
//  F1 League
//
//  Created by Alejandro Miranda on 15/4/23.
//

import Foundation
func formatDate(_ date: Date) -> String {
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "dd-MM-yyyy (HH:mm)"

    // Convert the Date object to the desired output string format
    return outputFormatter.string(from: date)
}

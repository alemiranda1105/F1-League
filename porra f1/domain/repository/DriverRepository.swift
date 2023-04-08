//
//  DriverRepository.swift
//  F1 League
//
//  Created by Alejandro Miranda on 8/4/23.
//

import Foundation

protocol DriverRepository {
    
    func getAllDrivers() async -> ([Driver], String)
    
}

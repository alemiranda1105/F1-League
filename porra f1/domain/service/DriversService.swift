//
//  DriversService.swift
//  porra f1
//
//  Created by Alejandro Miranda on 25/3/23.
//

import Foundation
import FirebaseFirestore

class DriversService {
    private let driverRepository = DriverRepositoryImpl()
    
    func getAllDrivers() async -> ([Driver], String) {
        return await driverRepository.getAllDrivers()
    }
}

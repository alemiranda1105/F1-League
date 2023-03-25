//
//  DriversView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 25/3/23.
//

import SwiftUI

struct DriversView: View {
    @ObservedObject private var driversService = DriversService()
    
    @State private var drivers = [Driver]()
    @State private var error: String?
    @State private var pending = true
    
    private func loadDrivers() {
        Task {
            (self.drivers, self.error) = await driversService.getAllDrivers()
            print(self.drivers)
            self.pending = !(error == nil || drivers.isEmpty)
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    if pending {
                        ProgressView() {
                            Text("loading-text")
                        }
                    } else if !drivers.isEmpty {
                        ForEach($drivers, id: \.driverId) { driver in
                            DriversListItemView(driver: driver)
                        }
                    }
                }
            }
            .navigationTitle("drivers-view")
            .onAppear {
                loadDrivers()
            }
        }
    }
}

struct DriversView_Previews: PreviewProvider {
    static var previews: some View {
        DriversView()
    }
}

//
//  DriversView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 25/3/23.
//

import SwiftUI

struct DriversView: View {
    private let driversService = DriversService()
    
    @State private var drivers = [Driver]()
    @State private var error = ""
    @State private var pending = true
    
    private func loadDrivers() {
        Task {
            (self.drivers, self.error) = await driversService.getAllDrivers()
            self.pending = !(error.isEmpty || drivers.isEmpty)
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
            .refreshable {
                loadDrivers()
            }
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

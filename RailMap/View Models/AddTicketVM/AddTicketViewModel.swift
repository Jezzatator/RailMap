//
//  AddTicketViewModel.swift
//  RailMap
//
//  Created by Jérémie - Ada on 14/09/2023.
//

import Foundation

extension AddTicket {
    @MainActor class AddTicketViewModel: ObservableObject {
        
        @Published var vehicleJourneys = [VehicleJourney]()
        
        func fetchHeadsignAddTicket(headsign: String) async {
            let urlString = "https://api.navitia.io/v1/coverage/fr-se/physical_modes/physical_mode%3ATrain/vehicle_journeys//?headsign=\(headsign)&"
            
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            
            var request = URLRequest(url: url)
            let username = "22c8f870-f331-446c-9694-749c67f88fa6"
            let loginData = "\(username):".data(using: .utf8)!
            let base64LoginData = loginData.base64EncodedString()
            request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let decodedResponse = try JSONDecoder().decode(VehiculeJourneys.self, from: data)
                self.vehicleJourneys = decodedResponse.vehicleJourneys
            } catch {
                print("Error: \(error)")
            }
        }
    }
}


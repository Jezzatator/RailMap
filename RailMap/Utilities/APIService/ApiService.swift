//
//  ApiService.swift
//  RailMap
//
//  Created by Jérémie - Ada on 08/09/2023.
//

import Foundation


class ApiService : ApiServiceProtocole {
    var vehicleJourneys: [VehicleJourney]?
    
    func fetchVJ(trainNumber: String, completion: @escaping (Result<VehiculeJourneys, Error>) -> Void) async {
        
        let urlString = "\(NavitiaEndpoint.base)\(NavitiaEndpoint.VehicleJourneys.endpoint(trainNumber: trainNumber))"
            
            guard let url = URL(string: urlString) else {
                print("URL invalide")
                return
            }
            
            var request = URLRequest(url: url)
            request.setValue(APIHeader.authorization, forHTTPHeaderField: "Authorization")
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let decodedResponse = try JSONDecoder().decode(VehiculeJourneys.self, from: data)
                self.vehicleJourneys = decodedResponse.vehicleJourneys
            } catch {
                print("Erreur : \(error)")
            }
    }
}

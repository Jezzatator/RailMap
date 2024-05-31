//
//  Endpoints.swift
//  RailMap
//
//  Created by Jérémie - Ada on 08/09/2023.
//

import Foundation


//Endpoint
enum NavitiaEndpoint {
    
    static let base = "https://api.navitia.io/v1/coverage/fr-se/"
    
    enum VehicleJourneys {
        static func endpoint(trainNumber: String) -> String {
            return "physical_modes/physical_mode%3ATrain/vehicle_journeys/?headsign=\(trainNumber)"
        }
    }
}

//Header

enum APIHeader {
    static let username = "22c8f870-f331-446c-9694-749c67f88fa6"
    static var authorization: String {
        let loginData = "\(username):".data(using: .utf8)!
        let base64LoginData = loginData.base64EncodedString()
        return "Basic \(base64LoginData)"
    }
}

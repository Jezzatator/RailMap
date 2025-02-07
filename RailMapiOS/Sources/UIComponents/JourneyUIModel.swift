//
//  JourneyUIModel.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 18/09/2024.
//

import Foundation

struct JourneyUIModel: Codable {
    var archived: Bool
    let company : String
    var endDate: String
    let heading: String
    let id: UUID
    let idVehicleJourney: String
    let startDate: String
    
    var stops: [StopUIModel]
    var departureStop: StopUIModel
    var arrivalStop: StopUIModel
}

struct StopUIModel: Codable {
    var arrivalTimeUTC: Date
    var departureTimeUTC: Date
    let status: String
    var stopInfo: StopInfoUIModel
}

struct StopInfoUIModel: Codable {
    let adress: String
    let coord: String
    let dropOffAllowed: Bool
    let id: String
    let label: String
    let pickUpAllowed: Bool
    let skippedStop: Bool
}

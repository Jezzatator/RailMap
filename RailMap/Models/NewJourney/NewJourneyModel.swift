//
//  JourneyModel.swift
//  RailMap
//
//  Created by Jérémie - Ada on 27/09/2023.
//

import SwiftUI
import Foundation

struct NewJourneyModel {
    var startDate: Date
    var endDate: Date
    var headsign: String
    var idVehicleJourney: String
    var company: String

    var stops: [NewStop]

    init(
        startDate: Date,
        endDate: Date,
        headsign: String,
        idVehicleJourney: String,
        company: String,
        stops: [NewStop] = []
    ) {
        self.startDate = startDate
        self.endDate = endDate
        self.headsign = headsign
        self.idVehicleJourney = idVehicleJourney
        self.company = company
        self.stops = stops
    }
}



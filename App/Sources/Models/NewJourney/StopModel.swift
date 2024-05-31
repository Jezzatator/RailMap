//
//  StopModel.swift
//  RailMap
//
//  Created by Jérémie - Ada on 27/09/2023.
//

import SwiftUI

struct NewStop {
    
    var arrivalTimeUTC: Date
    var departureTimeUTC: Date
    var status: String
    var stopInfo: NewStopInfo?
    
    
    init(id: UUID = UUID(),
         arrivalTimeUTC: Date,
         departureTimeUTC: Date,
         status: String,
         stopInfo:NewStopInfo) {
        self.arrivalTimeUTC = arrivalTimeUTC
        self.departureTimeUTC = departureTimeUTC
        self.status = status
        self.stopInfo = stopInfo
    }
    
}

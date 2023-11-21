//
//  StopModel.swift
//  RailMap
//
//  Created by Jérémie - Ada on 27/09/2023.
//

//import SwiftData
//import SwiftUI
//
//@Model
//final class Stop {
//    
//    var arrivalTimeUTC: Date
//    var departureTimeUTC: Date
//    var status: String
//    var stopInfo: [StopInfo]? = []
//    
//    @Relationship(deleteRule: .nullify, inverse: \Journey.stops)
//    var journey: Journey?
//    
//    init(id: UUID = UUID(),
//         arrivalTimeUTC: Date,
//         departureTimeUTC: Date,
//         status: String,
//         stopInfo:[StopInfo]) {
//        self.arrivalTimeUTC = arrivalTimeUTC
//        self.departureTimeUTC = departureTimeUTC
//        self.status = status
//        self.stopInfo = stopInfo
//    }
//    
//}

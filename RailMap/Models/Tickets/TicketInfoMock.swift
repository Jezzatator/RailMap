//
//  TicketInfo.swift
//  FlightTicketBrowser
//
//  Created by Takuya Aso on 2021/12/25.
//

import SwiftUI

// MARK: - TicketInfo
struct TicketInfo: Decodable {
    var trainType: TrainType
    var departure: String
    var departureCode: String
    var destination: String
    var destinationCode: String
    var compagny: String
    var trainNumber: String
    var hall: String
    var platform: String
    var date: String
    var boardingTime: String
    var departureTime: String
    var arrivalTime: String
    var journeyTime: String
    var seatNumber: String
    var passenger: String
    var passportNumber: String
    var eTicketNumber: String
    var bookingCode: String
    var payment: String
    var price: String

    enum CodingKeys: String, CodingKey {
        case trainType = "train_type"
        case departure
        case departureCode = "departure_code"
        case destination
        case destinationCode = "destination_code"
        case compagny = "compagny"
        case trainNumber = "train_number"
        case hall
        case platform
        case date
        case boardingTime = "boarding_time"
        case departureTime = "departure_time"
        case arrivalTime = "arrival_time"
        case journeyTime = "journey_time"
        case seatNumber = "seat_number"
        case passenger
        case passportNumber = "passport_number"
        case eTicketNumber = "e_ticket_number"
        case bookingCode = "booking_code"
        case payment
        case price
    }
}

enum TrainType: String, Decodable, CaseIterable {
    case international = "International"
    case domestic = "Domestic"
    
    var themeColor: Color {
        switch self {
        case .international:
            return .red
        case .domestic:
            return .indigo
        }
    }
}

let sampleTicketData: [TicketInfo] = [
    TicketInfo(trainType: .domestic,
               departure: "Paris", departureCode: "Gare de Lyon",
               destination: "Perpignan", destinationCode: "Gare de Perpignan",
               compagny: "SNCF", trainNumber: "66111",
               hall: "3", platform: "105",
               date: "4 Juin", boardingTime: "22:25",
               departureTime: "22:55", arrivalTime: "15:20",
               journeyTime: "9H 25M", seatNumber: "29A",
               passenger: "John Smith", passportNumber: "TX0123456",
               eTicketNumber: "0120 345 6789", bookingCode: "THANKU77",
               payment: "VISA *** **77", price: "$1099.99")
]


//
//  TicketInfo.swift
//  FlightTicketBrowser
//
//  Created by Takuya Aso on 2021/12/25.
//

import SwiftUI

// MARK: - TicketInfo
struct TicketInfo: Decodable {
    let trainType: TrainType
    let departure: String
    let departureCode: String
    let destination: String
    let destinationCode: String
    let `operator`: String
    let trainNumber: String
    let hall: String
    let platform: String
    let date: String
    let boardingTime: String
    let departureTime: String
    let arrivalTime: String
    let journeyTime: String
    let seatNumber: String
    let passenger: String
    let passportNumber: String
    let eTicketNumber: String
    let bookingCode: String
    let payment: String
    let price: String

    enum CodingKeys: String, CodingKey {
        case trainType = "train_type"
        case departure
        case departureCode = "departure_code"
        case destination
        case destinationCode = "destination_code"
        case `operator` = "operator"
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
               operator: "SNCF", trainNumber: "66111",
               hall: "3", platform: "105",
               date: "4 Juin", boardingTime: "22:25",
               departureTime: "22:55", arrivalTime: "15:20",
               journeyTime: "9H 25M", seatNumber: "29A",
               passenger: "John Smith", passportNumber: "TX0123456",
               eTicketNumber: "0120 345 6789", bookingCode: "THANKU77",
               payment: "VISA *** **77", price: "$1099.99")
]


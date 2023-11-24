////
////  NewJourneyVM.swift
////  RailMap
////
////  Created by Jérémie - Ada on 23/11/2023.
////

import SwiftUI
import Foundation
import CoreData

class NewJourneyVM: ObservableObject {
    
    @StateObject var viewModel = AddTicketViewModel()

    @Published var newJourney: NewJourneyModel
    
    init(newJourney: NewJourneyModel) {
        self.newJourney = newJourney
    }
    
    func addNewJourney(headsign: String, selectedDate: Date, Departure: String, Arrival: String, vehiculeJourneyID: String) {
        
        if let index = viewModel.vehicleJourneys.firstIndex(where: { $0.id == vehiculeJourneyID }) {
            let selectedVehicleJourney = viewModel.vehicleJourneys[index]
            newJourney.idVehicleJourney = vehiculeJourneyID
            newJourney.headsign = headsign
            newJourney.company = selectedVehicleJourney.name
            newJourney.startDate = selectedDate
            newJourney.endDate = selectedDate
            
            for stop in selectedVehicleJourney.stopTimes {
                
                var stopInfo = stop.stopPoint
                let newStopInfo = NewStopInfo(
                    id: stopInfo.id,
                    label: stopInfo.label,
                    coord: convertCoorInString(coord: stopInfo.coord),
                    adress: stopInfo.label,
                    pickUpAllowed: stop.pickupAllowed,
                    dropOffAllowed: stop.dropOffAllowed,
                    skippedStop: stop.skippedStop)
                
                let newStop = NewStop(arrivalTimeUTC: convertStringtoUTCDate(stop.utcArrivalTime)!, departureTimeUTC: convertStringtoUTCDate(stop.utcDepartureTime)!, status: checkStatus(departure: Departure, arrival: Arrival), stopInfo: newStopInfo)
                
                
                func checkStatus(departure: String, arrival: String) -> String {
                    
                    var departureSelected = false
                    var arrivalSelected = false
                    
                    switch stop.stopPoint.name {
                    case departure:
                        departureSelected = true
                        return "departure"
                    case arrival:
                        arrivalSelected = true
                        return "arrival"
                    default:
                        if departureSelected && !arrivalSelected {
                            return "transit"
                        } else if departureSelected && arrivalSelected {
                            return "off"
                        } else {
                            return "off"
                        }
                    }
                    

                }
            }
        }

    }
    
    
    func convertStringtoUTCDate(_ timeString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HHmmss"
        formatter.timeZone = TimeZone(identifier: "UTC")
        
        if let date = formatter.date(from: timeString) {
            return date
        } else {
            print("Failed to convert string to UTC date.")
            return nil
        }
    }
    
    func convertCoorInString(coord: Coord) -> String {
        return "(\(coord.lon), \(coord.lat)"
    }
    
}

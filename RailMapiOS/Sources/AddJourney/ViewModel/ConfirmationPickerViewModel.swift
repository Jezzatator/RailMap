//
//  ConfirmationPickerViewModel.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 19/01/2025.
//

import Foundation
import SwiftUICore

final class ConfirmationPickerViewModel: ObservableObject {
    @Environment(\.managedObjectContext) var moc
    private var dataController: DataController

    @Published var pickedJourney: DateRow
    
    @Published var departureStationInfo: StopTime?
    @Published var arrivalStationInfo: StopTime?


    
    public init(pickedJourney: DateRow, dataController: DataController) {
        self.dataController = dataController
        self.pickedJourney = pickedJourney
        
//        self.pickedJourney.company = resolveCompany(self.pickedJourney.journey.stopTimes.first?.stopPoint.id)
        self.departureStationInfo = getStopPointInfo(
            from: self.pickedJourney.journey,
            with: self.pickedJourney.departureStationID)
        self.arrivalStationInfo = getStopPointInfo(
            from: self.pickedJourney.journey,
            with: self.pickedJourney.arrivalStationID)
    }
    
    func convertToDate(from timeString: String, using baseDate: Date) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        
        guard let timeOnlyDate = dateFormatter.date(from: timeString) else {
            return nil
        }
        
        let calendar = Calendar.current
        let baseComponents = calendar.dateComponents([.year, .month, .day], from: baseDate)
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: timeOnlyDate)
        
        return calendar.date(bySettingHour: timeComponents.hour ?? 0,
                             minute: timeComponents.minute ?? 0,
                             second: timeComponents.second ?? 0,
                             of: calendar.date(from: baseComponents) ?? baseDate)
    }
    
    func saveNewJourney(_ newJourney: NewJourneyModel) {
        dataController.saveJourney(newJourney: newJourney)
    }
    
    func resolveCompany(_ code: String?) -> String? {
        guard let code = code else {
            return nil
        }
        
        let elements = code.split(separator: "-")
        if let premierElement = elements.first {
            let typeTransport = premierElement
                .split(separator: ":")
                .last?
                .replacingOccurrences(of: "OCE", with: "")
            return typeTransport

        } else {
            return nil
        }
    }
    
    func getStopPointInfo(from journey: VehicleJourney, with stopPointID: String?) -> StopTime? {
        guard getStopPointInfo != nil else {
            return nil
        }
            for stopTime in journey.stopTimes {
                if stopTime.stopPoint.id == stopPointID {
                    return stopTime
            }
        }
        return nil
    }
}

extension DateRow {
    func toNewJourneyModel() -> NewJourneyModel? {
        guard let departureID = departureStationID,
              let arrivalID = arrivalStationID,
              let departureStop = journey.stopTimes.first(where: { $0.stopPoint.id == departureID }),
              let arrivalStop = journey.stopTimes.first(where: { $0.stopPoint.id == arrivalID }),
              let startDate = combineDateWithTime(date: date, timeString: departureStop.utcDepartureTime),
              let endDate = combineDateWithTime(date: date, timeString: arrivalStop.utcArrivalTime) else {
            return nil
        }

        let stops = journey.stopTimes.compactMap { stopTime -> NewStop? in
            guard let arrivalTime = combineDateWithTime(date: date, timeString: stopTime.utcArrivalTime),
                  let departureTime = combineDateWithTime(date: date, timeString: stopTime.utcDepartureTime) else {
                return nil
            }
            
            var status: String {
                if stopTime.stopPoint.id == departureID {
                    return "departure"
                } else if stopTime.stopPoint.id == arrivalID {
                    return "arrival"
                } else {
                    return ""
                }
            }

            return NewStop(
                arrivalTimeUTC: arrivalTime,
                departureTimeUTC: departureTime,
                status: status,
                stopInfo: NewStopInfo(
                    id: stopTime.stopPoint.id,
                    label: stopTime.stopPoint.label,
                    coord: "\(stopTime.stopPoint.coord.lat),\(stopTime.stopPoint.coord.lon)",
                    adress: "N/A adress", // À compléter
                    pickUpAllowed: stopTime.pickupAllowed,
                    dropOffAllowed: stopTime.dropOffAllowed,
                    skippedStop: stopTime.skippedStop
                )
            )
        }

        return NewJourneyModel(
            startDate: startDate,
            endDate: endDate,
            headsign: journey.headsign,
            idVehicleJourney: journey.id,
            company: company ?? "Unknown",
            stops: stops
        )
    }
    
    private func combineDateWithTime(date: Date, timeString: String?) -> Date? {
        guard let timeString = timeString else { return nil }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)

        let fullDateString = String(format: "%04d-%02d-%02d %@", components.year ?? 2000, components.month ?? 1, components.day ?? 1, timeString)

        return dateFormatter.date(from: fullDateString)
    }
}

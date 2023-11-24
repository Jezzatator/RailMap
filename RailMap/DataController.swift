//
//  DataController.swift
//  RailMap
//
//  Created by Jérémie - Ada on 17/11/2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "RailMap")
    
    @Published var journeys: [Journey] = [Journey]()

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Data saved to CoreData")
            } catch {
                print("Failed to save data: \(error.localizedDescription)")
            }
        }
    }
    
    // Save a new journey to CoreData
    func saveJourney(newJourney: NewJourneyModel) {
        let context = container.viewContext

        let journey = Journey(context: context)
        journey.startDate = newJourney.startDate
        journey.endDate = newJourney.endDate
        journey.headsign = newJourney.headsign
        journey.idVehiculeJourney = newJourney.idVehicleJourney
        journey.company = newJourney.company

        for newStop in newJourney.stops {
            let stop = Stop(context: context)
            stop.arrivalTimeUTC = newStop.arrivalTimeUTC
            stop.departureTimeUTC = newStop.departureTimeUTC
            stop.status = newStop.status

            if let newStopInfo = newStop.stopInfo {
                let stopInfo = StopInfo(context: context)
                stopInfo.id = newStopInfo.id
                stopInfo.label = newStopInfo.label
                stopInfo.coord = newStopInfo.coord
                stopInfo.adress = newStopInfo.adress
                stopInfo.pickUpAllowed = newStopInfo.pickUpAllowed
                stopInfo.dropOffAllowed = newStopInfo.dropOffAllowed
                stopInfo.skippedStop = newStopInfo.skippedStop

                stopInfo.stop = stop
                stop.stopinfo = stopInfo
            }

            journey.addToStops(stop)
        }

        saveContext()
    }
}

//
//  ConfirmationPickerView.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 19/01/2025.
//

import SwiftUI

struct ConfirmationPickerView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var viewModel: ConfirmationPickerViewModel
    
    var onNext: () -> Void

    var body: some View {
        JourneyHeaderView(company: viewModel.pickedJourney.company,
                          headsign: viewModel.pickedJourney.journey.headsign,
                          departureCity: viewModel.departureStationInfo?.stopPoint.label,
                          arrivalCity: viewModel.arrivalStationInfo?.stopPoint.label,
                          departureDate: viewModel.pickedJourney.date,
                          size: CGSize(width: 60, height: 60))
        
        VStack(spacing: 0) {
            Divider()
            ScrollView(showsIndicators: true) {
                if let DStationInfo = viewModel.departureStationInfo,
                   let AStationInfo = viewModel.arrivalStationInfo,
                   let departureDate = viewModel.convertToDate(from: DStationInfo.arrivalTime, using: viewModel.pickedJourney.date),
                   let arrivalDate = viewModel.convertToDate(from: AStationInfo.arrivalTime, using: viewModel.pickedJourney.date) {
                    VStack{
                        StationView(stationLabel: DStationInfo.stopPoint.name, date: departureDate, arrival: false)
                        DurationView(startDate: departureDate, endDate : arrivalDate)
                        StationView(stationLabel: AStationInfo.stopPoint.label, date: arrivalDate, arrival: true)
                    }
                    .padding(.vertical)
                }
                HStack {
                    ClippedRow(
                        title: "Booking Code",
                        bodyTexts: ["Tap to Edit"],
                        icon: "ticket.fill",
                        displayMode: .small
                    )
                    
                    ClippedRow(
                        title: "Seat",
                        bodyTexts: ["Tap to Edit"],
                        icon: "carseat.right.fill",
                        displayMode: .small
                    )
                }
                .padding()
                
                LazyVStack(alignment: .leading) {
                    Text("Good to know")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ClippedRow(title: "Prevision à l'arrivée",
                               bodyTexts: ["14°C et ensoleillée"],
                               icon: "cloud.sun.fill"
                    )
                }
                .padding(.horizontal)
                Spacer()
            }
            .padding(.top, -15)
            .padding(.vertical)
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Confirmer") {
                    let newJourney = viewModel.pickedJourney.toNewJourneyModel()
                    if let newJourney = newJourney {
                        DispatchQueue.main.async {
                            viewModel.saveNewJourney(newJourney)
                            onNext()
                        }
                    }
                }
                .font(.headline)
            }
        }
    }
}

//#Preview {
//    let mockDatePickerViewModel: ConfirmationPickerViewModel = {
//        let dateFormatter = ISO8601DateFormatter()
//        
//        let stopPoint = StopPoint(
//            id: "StopPoint:OCETGV INOUI-87686006",
//            name: "Paris Gare de Lyon Hall 1 - 2",
//            codes: [Code(type: .gtfsStopCode, value: "StopPoint:OCETGV INOUI-87686006")],
//            label: "Paris Gare de Lyon Hall 1 - 2",
//            coord: Coord(lon: "2,373481", lat: "48,844945"),
//            links: [],
//            equipments: []
//        )
//        
//        let stopTime = StopTime(
//            arrivalTime: "11:52:00",
//            utcArrivalTime: "10:52:00",
//            departureTime: "11:52:00",
//            utcDepartureTime: "10:52:00",
//            headsign: "6613",
//            stopPoint: stopPoint,
//            pickupAllowed: true,
//            dropOffAllowed: false,
//            skippedStop: false
//        )
//        
//        let weekPattern = WeekPattern(
//            monday: true,
//            tuesday: false,
//            wednesday: false,
//            thursday: false,
//            friday: true,
//            saturday: false,
//            sunday: false
//        )
//        
//        let calendar = VehicleCalendar(
//            weekPattern: weekPattern,
//            exceptions: [Exception(datetime: "2025-01-17", type: .add)],
//            activePeriods: [ActivePeriod(begin: "2025-01-17", end: "2025-01-31")]
//        )
//        
//        let journey = VehicleJourney(
//            id: "OCESN6613F3511394:2025-01-14T04:48:49Z",
//            name: "6613",
//            journeyPattern: JourneyPattern(id: "OCESN6613F3511394:2025-01-14T04:48:49Z", name: "6613"),
//            stopTimes: [stopTime],
//            codes: [Code(type: .source, value: "GTFS")],
//            validityPattern: ValidityPattern(beginningDate: "2025-01-16T23:00:00Z", days: "Custom Dates"),
//            calendars: [calendar],
//            trip: JourneyPattern(id: "OCESN6613F3511394:2025-01-14T04:48:49Z", name: "6613"),
//            disruptions: [],
//            headsign: "6613"
//        )
//        
//        let dateRow = DateRow(
//            journeyId: "OCESN6613F3511394:2025-01-14T04:48:49Z",
//            date: dateFormatter.date(from: "2025-01-17T10:52:00Z")!,
//            journey: journey,
//            departureStationID: "StopPoint:OCETGV INOUI-87686006",
//            arrivalStationID: "StopPoint:OCETGV INOUI-87722025"
//        )
//        
//        return ConfirmationPickerViewModel(pickedJourney: dateRow)
//    }()
//
//    ConfirmationPickerView(viewModel: mockDatePickerViewModel, onNext: <#() -> Void#>)
//}

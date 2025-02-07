//
//  AddTicketV.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 19/07/2024.
//

import SwiftUI

struct AddTicketV: View {
    @StateObject var viewModel = AddTicketVM()
    @ObservedObject var router: Router
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    
    @Binding var searchText: String
    @State private var currentStep: TicketStep = .datePicker
    @State private var selectedDateRow: DateRow?
    @State private var pickedJourney: DateRow?
    
    var body: some View {
        VStack {
            if viewModel.vehicleJourneys.isEmpty && searchText == "" {
                EmptyListJourneyView()
            } else if viewModel.vehicleJourneys.isEmpty {
                EmptyListJourneyView(title: "No Journey found!", subtitle: "Try searching for another journey")
            } else {
                switch currentStep {
                case .datePicker:
                    DatePickerView(viewModel: DatePickerViewModel(dateRows: dateRows), router: router) { selectedRow in
                        router.navigate(to: .stationPicker(selectedRow))
                    }
                case .stationPicker:
                    if let selectedDateRow = selectedDateRow {
                        StationPickerView(viewModel: StationPickerViewModel(pickedJourney: selectedDateRow)) { pickedJourney in
                            router.navigate(to: .confirmation(pickedJourney))
                        }
                    }
                case .confirmation:
                    if let pickedJourney = pickedJourney {
                        ConfirmationPickerView(viewModel: ConfirmationPickerViewModel(pickedJourney: pickedJourney, dataController: dataController)) {
                            router.navigateToRoot()
                        }

                    }
                }
            }
        }
        .onChange(of: searchText) { newValue in
            Task {
                await viewModel.fetchHeadsignAddTicket(headsign: newValue)
            }
        }
    }
    
    var dateRows: [DateRow] {
        var rows: [DateRow] = []
        let passageDays = viewModel.getPassageDays(from: viewModel.vehicleJourneys)
        
        for journey in viewModel.vehicleJourneys {
            if let dates = passageDays[journey.id] {
                for date in dates {
                    rows.append(DateRow(journeyId: journey.id, date: date, journey: journey))
                }
            }
        }
        return rows.sorted { $0.date < $1.date }
    }
}

enum TicketStep {
    case datePicker
    case stationPicker
    case confirmation
}

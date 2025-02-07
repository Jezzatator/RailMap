//
//  BottomSheetView.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 12/07/2024.
//

//  BottomSheetView.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 12/07/2024.
//

import SwiftUI
import CoreData

struct BottomSheetView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Journey.startDate, ascending: true)]) var journeys: FetchedResults<Journey>
    @ObservedObject var router: Router

    @Binding var sheetSize: PresentationDetent
    @State private var searchText = ""
    @State private var searchPresented: Bool = false {
        didSet {
            if searchPresented {
                sheetSize = .large
            }
        }
    }
        
    var filteredJourneys: [Journey] {
        searchText.isEmpty ? Array(journeys) : journeys.filter { $0.headsign?.contains(searchText) ?? false }
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                if searchPresented && filteredJourneys.isEmpty {
                    AddTicketV(router: router, searchText: $searchText)
                        .padding(.top)
                } else if !searchPresented && filteredJourneys.isEmpty {
                    EmptyListJourneyView()
                } else {
                    List(filteredJourneys, id: \.objectID) { journey in
                        JourneyRowView(journey: journey)
                            .onTapGesture {
                                withAnimation {
                                    router.navigate(to: .journeyDetails(objectID: journey.objectID))
                                    updateSheetSize()
                                }
                            }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationDestination(for: Router.Flow.self) { flow in
                switch flow {
                case .journeys:
                    Text("My Journeys")
                case .addTicket(let searchText):
                    AddTicketV(router: router, searchText: .constant(searchText ?? ""))
                case .journeyDetails(let objectID):
                    if let journey = moc.object(with: objectID) as? Journey {
                        JourneyDetailsV(journey: journey)
                    } else {
                                Text("Journey not found")
                            }
                case .stationPicker(let selectedDateRow):
                    StationPickerView(viewModel: StationPickerViewModel(pickedJourney: selectedDateRow)) { pickedJourney in
                        router.navigate(to: .confirmation(pickedJourney))
                    }
                case .confirmation(let pickedJourney):
                    ConfirmationPickerView(viewModel: ConfirmationPickerViewModel(pickedJourney: pickedJourney, dataController: dataController)) {
                        router.navigateToRoot()
                    }
                case .datePicker(let dateRows):
                    DatePickerView(viewModel: DatePickerViewModel(dateRows: dateRows), router: router) { selectedRow in
                        router.navigate(to: .stationPicker(selectedRow))
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(searchPresented && filteredJourneys.isEmpty ? "Add a Journey" : "My Journeys")
                        .fontWeight(.bold)
                        .font(.title)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if searchPresented && filteredJourneys.isEmpty {
                        Button(action: {
                            if journeys.isEmpty {
                                let dataController = DataController()
                                dataController.createMockJourneys(context: moc)
                            }
                        }) {
                            Text("Save")
                                .foregroundColor(.blue)
                        }
                    } else {
                        Button(action: {
                            let dataController = DataController()
                            dataController.createMockJourneys(context: moc)
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .searchable(text: $searchText, isPresented: $searchPresented, placement: .navigationBarDrawer(displayMode: .always))
            .searchPresentationToolbarBehavior(.avoidHidingContent)
        }
    }
    
    private func updateSheetSize() {
        switch sheetSize {
        case .large, .medium:
            sheetSize = .large
        default:
            sheetSize = .medium
        }
    }
}

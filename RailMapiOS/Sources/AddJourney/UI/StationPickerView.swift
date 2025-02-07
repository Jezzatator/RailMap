//
//  StationPickerView.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 17/01/2025.
//

import SwiftUI
import Foundation

struct StationPickerView: View {
    @EnvironmentObject var dataController: DataController

    @ObservedObject var viewModel: StationPickerViewModel
    @State var departureStation: String?
    @State var arrivalStation: String?
    @State var pickerMode: PickerModeStation = .pickUpDeparture
    
    var onNext: (DateRow) -> Void
    
    var body: some View {
        List {
            ForEach(viewModel.pickedJourney.journey.stopTimes, id: \.stopPoint.id) { stopTime in
                StationRow(
                    stopTime: stopTime,
                    cityName: viewModel.cityNames[stopTime.stopPoint.id],
                    isSelected: isStationSelected(stopTime),
                    isSelectable: isStationSelectable(stopTime)
                )
                .onTapGesture {
                    if isStationSelectable(stopTime) {
                        toggleStationSelection(stopTime)
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle(Text(pickerMode == .pickUpDeparture ? "Pick a starting station" : "Pick an ending station"))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if departureStation != nil && arrivalStation != nil {
                    Button("Confirmer") {
                        var resolvedPickedJourney = viewModel.pickedJourney
                        resolvedPickedJourney.departureStationID = departureStation
                        resolvedPickedJourney.arrivalStationID = arrivalStation
                        onNext(resolvedPickedJourney)
                    }
                    .font(.headline)
                }
            }
        }
    }
    
    private func isStationSelected(_ stopTime: StopTime) -> Bool {
        stopTime.stopPoint.id == departureStation || stopTime.stopPoint.id == arrivalStation
    }
    
    private func isStationSelectable(_ stopTime: StopTime) -> Bool {
        switch pickerMode {
        case .pickUpDeparture:
            return stopTime.pickupAllowed
        case .dropOffArrival:
            guard let departureIdx = viewModel.pickedJourney.journey.stopTimes.firstIndex(where: { $0.stopPoint.id == departureStation }) else {
                return false
            }
            let currentIdx = viewModel.pickedJourney.journey.stopTimes.firstIndex(where: { $0.stopPoint.id == stopTime.stopPoint.id })!
            return currentIdx > departureIdx && stopTime.dropOffAllowed
        }
    }
    
    private func toggleStationSelection(_ stopTime: StopTime) {
        let stopID = stopTime.stopPoint.id
        
        switch pickerMode {
        case .pickUpDeparture:
            if departureStation == stopID {
                departureStation = nil
                arrivalStation = nil
                pickerMode = .pickUpDeparture
            } else {
                departureStation = stopID
                pickerMode = .dropOffArrival
            }
            
        case .dropOffArrival:
            if arrivalStation == stopID {
                arrivalStation = nil
            } else if departureStation != stopID {
                arrivalStation = stopID
            }
        }
    }
}

enum PickerModeStation {
    case pickUpDeparture
    case dropOffArrival
}


struct StationRow: View {
    let stopTime: StopTime
    let cityName: String?
    let isSelected: Bool
    let isSelectable: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stopTime.stopPoint.name)
                    .font(.headline)
                HStack {
                    if let cityName = cityName {
                        Text(cityName)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Text(stopTime.arrivalTime)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
            }
        }
        .opacity(isSelectable ? 1 : 0.5)
        .contentShape(Rectangle())
    }
}

enum PickerMode {
    case pickUpDeparture
    case dropOffArrival
}

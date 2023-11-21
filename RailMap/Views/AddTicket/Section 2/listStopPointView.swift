//
//  listStopPointView.swift
//  RailMap
//
//  Created by Jérémie - Ada on 15/09/2023.
//

import SwiftUI

struct listStopPointView: View {
    
    @StateObject var viewModel: AddTicketViewModel
    @EnvironmentObject var addTicketInfoVM: AddTicketInfo
    
    @Binding var Departure: String?
    @Binding var Arrival: String?
    
    var body: some View {
        
            if !viewModel.vehicleJourneys.isEmpty {


                let firstVehicleJourney = viewModel.vehicleJourneys.first
                let firstStopTimes = firstVehicleJourney?.stopTimes
                if firstStopTimes != nil {
                    
                    List (firstVehicleJourney?.stopTimes ?? [], id: \.arrivalTime){ stopTime in

                        let stopName = stopTime.stopPoint.name
                        let formattedDepartureTime = viewModel.formattedHour(from: stopTime.departureTime)
                        let formattedArrivalTime = viewModel.formattedHour(from: stopTime.arrivalTime)
                        
                        
                        // Choix du Départ
                        let isLastStopPoint = firstStopTimes?.last?.stopPoint.name == stopName
                        
                        if Departure == nil {
                            Group {
                                if isLastStopPoint {
                                    Text("\(formattedArrivalTime) - \(stopName)")
                                        .foregroundColor(.gray)
                                } else {
                                    Text("\(formattedDepartureTime) - \(stopName)")
                                        .onTapGesture {
                                            Departure = stopName
                                            addTicketInfoVM.addTicketInfo[0].departureCode = stopName
                                            addTicketInfoVM.addTicketInfo[0].departureTime = formattedDepartureTime
                                        }
                                }
                            }
                        }
                        
                        // Choix de l'arrivée
                        if Departure != nil {
                            if let departureIndex = firstStopTimes?.firstIndex(where: { $0.stopPoint.name == Departure }) {
                                if let currentIndex = firstStopTimes?.firstIndex(where: { $0.stopPoint.name == stopName }) {
                                                                        
                                    if currentIndex <= departureIndex {
                                        Text("\(formattedDepartureTime) - \(stopName)")
                                            .foregroundColor(.gray)
                                    } else if Departure == stopName {
                                        Text("\(formattedArrivalTime) - \(stopName)")
                                            .foregroundColor(.blue)
                                    } else {
                                        Text("\(formattedArrivalTime) - \(stopName)")
                                            .onTapGesture {
                                                Arrival = stopName
                                                addTicketInfoVM.addTicketInfo[0].destinationCode = stopName
                                                addTicketInfoVM.addTicketInfo[0].arrivalTime = formattedArrivalTime
                                            }
                                    }
                                }
                            }
                        }
                    }
//                    .onChange(of: viewModel.vehicleJourneys) { newVehicleJourneys in
//                        print("Vehicle Journeys changed in listStopPointView: \(newVehicleJourneys[0].stopTimes)")
//                    }

                    .onAppear {
                        if let firstStopTime = firstStopTimes?.first {
                            let stopPointID = firstStopTime.stopPoint.id ?? "N/A"
                            addTicketInfoVM.addTicketInfo[0].compagny = viewModel.extractName(from: stopPointID)
                        } else {
                            print("On Appear - No first stop time available")
                        }
                    }
                    .listStyle(.plain)
                } else {
Text("")                            }
            } else {
                Group {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                Group {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
            }
        }
    }

#Preview {
    ContentView()
}

extension VehicleJourney: Equatable {
    static func == (lhs: VehicleJourney, rhs: VehicleJourney) -> Bool {
        // Comparez les propriétés pertinentes pour déterminer l'égalité
        // Exemple (à adapter à vos besoins) :
        return lhs.id == rhs.id
    }
}


//
//  AddTicketView.swift
//  RailMap
//
//  Created by Jérémie - Ada on 13/09/2023.
//

import SwiftUI

struct AddTicket: View {
    @StateObject var viewModel = AddTicketViewModel()
    @Environment(\.dismiss) var dismiss
    
    @State private var trainNum = ""
    @State var Date = "12 Septembre"
    @State var Hour = "15:10"
    @State var StopPoints = ["Paris Gare de Lyon", "Valence TGV Rhone Alpes Sud", "Nimes Pont du Gard", "Montpellier Sud e France", "Sete", "Agde", "Bezier", "Narbonne", "Perpignan "]
    
    @State var Departure: String?
    @State var Arrival: String?
    

    

    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 4) {
                    
                    //Section 1: Numéro de train
                    Group {
                        Text("Numéro de Train")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                            .padding(.leading)
                        Spacer()
                    }
                    TextField("Enter your tain's number", text: $trainNum)
                                    .foregroundColor(.black)
                                    .padding(.horizontal)
                                    .frame(height: 44, alignment: .center)
                                    .background(.thinMaterial)
                                    .cornerRadius(10)
                                    .keyboardType(.decimalPad)
                                    .onChange(of: trainNum) {
                                        Task {
                                            await viewModel.fetchHeadsignAddTicket(headsign: trainNum)
                                        }
                                    }
                    
                    //Style si pas de choix dans la date
                    HStack {
                        Text(Date)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(Hour)
                            .foregroundColor(.gray)
                    }
                    .padding()

                    //Style titre choix Depart/arrivé
                    Group {
                        HStack {
                            if Departure == nil {
                                Text("Choississez votre gare de départ")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading)
                            } else {
                                Text("Choississez votre gare d'arrivée")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading)
                            }
                            Spacer()
                        }
                    }
                    
                    // Section 2: Liste des points d'arrêts
                    Group {
                        if !viewModel.vehicleJourneys.isEmpty {
                            let firstVehicleJourney = viewModel.vehicleJourneys.first
                            
                            let firstStopTimes = firstVehicleJourney?.stopTimes
                            if firstStopTimes != nil {
                                List (firstVehicleJourney?.stopTimes ?? [], id: \.arrivalTime){ stopTime in
                                    
                                    let stopName = stopTime.stopPoint.name
                                    
                                    // Choix du Départ
                                    let isLastStopPoint = firstStopTimes?.last?.stopPoint.name == stopName
                                    
                                    if Departure == nil {
                                        Group {
                                            if Departure == stopName || isLastStopPoint {
                                                Text(stopName)
                                                    .foregroundColor(.gray)
                                            } else {
                                                Text(stopName)
                                                    .onTapGesture {
                                                        Departure = stopName
                                                    }
                                            }
                                        }
                                    }
                                    
                                    // Choix de l'arrivée
                                    if Departure != nil {
                                        if let departureIndex = firstStopTimes?.firstIndex(where: { $0.stopPoint.name == Departure }) {
                                            if let currentIndex = firstStopTimes?.firstIndex(where: { $0.stopPoint.name == stopName }) {
                                                if currentIndex <= departureIndex {
                                                    Text(stopName)
                                                        .foregroundColor(.gray)
                                                } else {
                                                    Text(stopName)
                                                        .onTapGesture {
                                                            Arrival = stopName
                                                        }
                                                }
                                            }
                                        }
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
                    
                    //Section 3: Verification
                    
                    Group {
                        HStack {
                            Text("Depart :\(Departure ?? "")")
                            Text("Arrivée :\(Arrival ?? "")")
                        }
                    }
                    
                    //Seciton 4: Bouton enregistrer
                    
                    Group {
                        VStack {
                            Text("Enregistrer")
                                .foregroundStyle(.blue)
                        }
                    }
            }
            .padding()
            .navigationTitle("Add a ticket")
            .toolbar {
                Button(action: {dismiss()}, label: {
                    Text("Cancel")
                        .foregroundColor(.red)
                })
            }
            }
        }
    }
}

#Preview {
    AddTicket()
}

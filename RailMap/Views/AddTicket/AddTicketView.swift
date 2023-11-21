//
//  AddTicketView.swift
//  RailMap
//
//  Created by Jérémie - Ada on 13/09/2023.
//

import CoreData
import SwiftUI

struct AddTicket: View {
    
    @StateObject var viewModel = AddTicketViewModel()
    @EnvironmentObject var addTicketInfoVM: AddTicketInfo
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
   // @State private var newJourney = Journey()
    
    @State var trainNum = ""
    @State var selectedDay = ""
    @State var Date = "12 Septembre"
    @State var Hour = "15:10"
    @State var StopPoints = ["Paris Gare de Lyon", "Valence TGV Rhone Alpes Sud", "Nimes Pont du Gard", "Montpellier Sud de France", "Sete", "Agde", "Bezier", "Narbonne", "Perpignan"]
    
    
    @State var Departure: String?
    @State var Arrival: String?
    
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 4) {
                    
                    //Section 1: Numéro de train et date/jour picker
                    Section1AddTicketView(viewModel: viewModel, trainNum: $trainNum)
                    
                    
                    // Section 2: Liste des points d'arrêts
                    // Style titre choix Depart/arrivé
                    
                    // ProgressView() a ajouter
                    // Erreur View a ajouter si pas de trains trouvé
                    
                    HStack {
                        if trainNum != "" {
                            if Departure == nil {
                                Section2SubtitleView(subTitle: "Choose your departure station")
                            } else {
                                Section2SubtitleView(subTitle: "Choose your arrival station")
                            }
                        } else {
                            Section2SubtitleView(subTitle: "Loading")
                        }
                        Spacer()
                        Group {
                            if viewModel.vehicleJourneys.first?.calendars.first != nil {
                                Picker("", selection: $selectedDay) {
//                                    ForEach(viewModel.convertCalendarToDDMMYY(calendar: viewModel.vehicleJourneys.first!.calendars.first!)!, id: \.self) {
                                    ForEach(Array(viewModel.datePickerVeehicleJourneys.keys.sorted(by: <)), id: \.self) { date in
                                        
                                            Text(viewModel.formatDate(date))
                                    
                                    }.onChange(of: selectedDay) {
                                        addTicketInfoVM.addTicketInfo[0].date = viewModel.formatDateLettre(selectedDay)
                                    }
                                }
                            } else {
                                Text("Date")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.trailing)
                    }
                    
                   listStopPointView(viewModel: viewModel, Departure: $Departure, Arrival: $Arrival)
                    
                    //Section 3: Verification
                    
                    TicketListRowView(ticketInfo: addTicketInfoVM.addTicketInfo[0])
                        .frame(height: 80.0)
                        .padding(.horizontal)
                        .previewLayout(PreviewLayout.sizeThatFits)
                    
                    //Seciton 4: Bouton enregistrer
                    
                    Group {
                        VStack {
                            Button("Save"){
                                
                                // init transfer données sur fetch sur class billet
                                //.disable a ajouter pour pas enregistrer des voyages avec des infos incompletes
                                //et donc créer une class intermediaire qui check les infos choisies puis lors de l'enregistrement transfer tout a une class ticket avec le reste des infos completes et cachée (tout les stop points, GEOJSON, etc)
                                withAnimation {
                                    //context.insert(newJourney)
                                }
                            }
                            .foregroundStyle(.blue)
                        }
                    }
                    .onChange(of: trainNum) {
                        // Ajout de l'opérateur dans le preview
                        if viewModel.vehicleJourneys != nil {
                            //addTicketInfoVM.addTicketInfo[0].compagny = viewModel.extractName(from: viewModel.vehicleJourneys[0].stopTimes[0].stopPoint.id)
                        }
                    }
                    .padding()
                    .navigationTitle("Add a journey")
                    .toolbar {
                        Button(action: {
                            addTicketInfoVM.addTicketInfo[0] = addTicketInfoVM.resetTicketInfo
                            dismiss()}, label: {
                                Text("Cancel")
                                    .foregroundColor(.red)
                            })
                    }
                }
            }
        }
    }
}

#Preview {
    AddTicket()
        .environmentObject(AddTicketInfo())
}

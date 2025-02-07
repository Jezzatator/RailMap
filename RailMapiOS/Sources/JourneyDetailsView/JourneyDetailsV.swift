//
//  JourneyDetailsV.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 19/07/2024.
//

import SwiftUI
import CoreData

struct JourneyDetailsV: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var journey: Journey
    
    var departureLabel: String {
        let stop: Stop = ((journey.stops as? Set<Stop>)?.first(where: { $0.status == "departure" }))!
        let stopInfoLabel = stop.stopinfo?.label
        return stopInfoLabel ?? "N/A"
    }
    
    var arrivalLabel: String {
        let stop: Stop = ((journey.stops as? Set<Stop>)?.first(where: { $0.status == "arrival" }))!
        let stopInfoLabel = stop.stopinfo?.label
        return stopInfoLabel ?? "N/A"
    }
    
    var body: some View {
        JourneyHeaderView(company: journey.company,
                          headsign: journey.headsign,
                          departureCity: departureLabel,
                          arrivalCity: arrivalLabel,
                          departureDate: journey.startDate,
                          size: CGSize(width: 60, height: 60))
        
        VStack(spacing: 0) {
            Divider()
            ScrollView(showsIndicators: true) {
                if let startDate = journey.startDate {
                    DepartureStatusView(status: .intime, time: startDate, station: "Gare de Lyon", hall: "3", platform: nil)
                }
                VStack{
                    StationView(stationLabel: departureLabel, date: journey.startDate!, arrival: false)
                    DurationView(startDate: journey.startDate, endDate: journey.endDate)
                    StationView(stationLabel: arrivalLabel, date: journey.endDate!, arrival: true)
                }
                .padding(.vertical)
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
                    
                    ClippedRow(title: "My history on This Route",
                               bodyTexts: ["14°C et ensoleillée","13°C et ensoleillée","12°C et ensoleillée"], displayMode: .large
                    )
                    
                    ClippedRow(title: "My history on This Route",
                               bodyTexts: ["14°C et ensoleillée","13°C et ensoleillée","12°C et ensoleillée"], displayMode: .large
                    )
                    
                    ClippedRow(title: "My history on This Route",
                               bodyTexts: ["14°C et ensoleillée","13°C et ensoleillée","12°C et ensoleillée"], displayMode: .large
                    )
                }
                .padding(.horizontal)
//                                } else {
//                                    Text("Aucune station disponible.")
//                                        .font(.subheadline)
//                            }
                Spacer()
            }
            .padding(.top, -15)
            .padding(.vertical)
            Spacer()
        }
    }
}

//#Preview {
//    let container = NSPersistentContainer.preview
//    let context = container.viewContext
//    
//    DataController.shared.createMockJourneys(context: context)
//    
//    let fetchRequest: NSFetchRequest<Journey> = Journey.fetchRequest()
//    fetchRequest.fetchLimit = 1
//    
//    guard let journey = try? context.fetch(fetchRequest).last else {
//        fatalError("Aucun voyage trouvé pour la prévisualisation.")
//    }
//    
//    return JourneyDetailsV(journey: journey)
//        .environment(\.managedObjectContext, context)
//}

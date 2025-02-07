//
//  JourneyRowView.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 12/07/2024.
//

import CoreData
import SwiftUI

struct JourneyRowView: View {
    @ObservedObject var viewModel: JourneyRowViewModel
    
    init(journey: Journey) {
        self.viewModel = JourneyRowViewModel(journey: journey)
    }
    
    var body: some View {
        VStack {
            JourneyRowHeader(company: viewModel.compagny, headsign: viewModel.headsign, duration: viewModel.duration)
            JourneyTimes(
                departureTime: viewModel.departureTime,
                departureLabel: viewModel.departureLabel,
                arrivalTime: viewModel.arrivalTime,
                arrivalLabel: viewModel.arrivalLabel
            )
            DashedDivider()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5, 3]))
                .frame(height: 1)
                .opacity(0.2)
                .foregroundColor(.gray)
                .padding(.horizontal, 10)
            JourneyRowFooter(departureDate: viewModel.departureDate)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8.0)
    }
}

#Preview {
    let context = NSPersistentContainer.preview.viewContext
    let fetchRequest: NSFetchRequest<Journey> = Journey.fetchRequest()
    fetchRequest.fetchLimit = 1
    
    guard let journey = try? context.fetch(fetchRequest).first else {
        fatalError("Aucun voyage trouvé pour la prévisualisation.")
    }
    
    return JourneyRowView(journey: journey)
        .environment(\.managedObjectContext, context)
}

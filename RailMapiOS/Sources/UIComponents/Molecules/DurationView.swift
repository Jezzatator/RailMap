//
//  DurationView.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 18/09/2024.
//

import Helpers
import SwiftUI

//TODO: Calculer la distance et l'afficher
struct DurationView: View {
    let startDate: Date?
    let endDate: Date?
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "clock")
                .foregroundStyle(.gray)
            Text(calculateDurationString(from: startDate, to: endDate))
                .font(.subheadline)
                .foregroundStyle(.gray)
            Text("•")
                .font(.subheadline)
                .foregroundStyle(.gray)
            Text("345 km")
                .font(.subheadline)
                .foregroundStyle(.gray)
            VStack { Divider() }
        }
        .padding(.horizontal)
    }
    
    func calculateDurationString(from startDate: Date?, to endDate: Date?) -> String {
        guard let startDate = startDate, let endDate = endDate else {
            return "Durée non disponible"
        }
        
        return startDate.duration(to: endDate)
    }
}

#Preview {
    DurationView(startDate: Date.now, endDate: Date.distantFuture)
}

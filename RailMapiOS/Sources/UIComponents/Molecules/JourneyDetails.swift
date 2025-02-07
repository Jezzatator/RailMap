//
//  JourneyDetails.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 18/09/2024.
//


import SwiftUI

struct JourneyDetails: View {
    let company: String
    let headsign: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(company)
            Text(headsign)
                .font(.caption2)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    JourneyDetails(company: "SNCF", headsign: "12345")
}

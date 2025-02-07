//
//  JourneyRowHeader.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 18/09/2024.
//


import SwiftUI

struct JourneyRowHeader: View {
    let company: String
    let headsign: String
    let duration: String
    
    var body: some View {
        HStack {
            CompanyLogo(company)
            JourneyDetails(company: company, headsign: headsign)
            Spacer()
            ClockIcon()
            Text(duration)
                .font(.caption2)
                .foregroundStyle(.gray)
        }
    }
}

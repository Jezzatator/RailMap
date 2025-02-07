//
//  JourneyRowFooter.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 18/09/2024.
//


import SwiftUI

struct JourneyRowFooter: View {
    let departureDate: String
    
    var body: some View {
        HStack {
            Text(departureDate)
                .font(.subheadline)
                .foregroundStyle(.gray)
            Spacer()
            Text("Direct")
                .font(.subheadline)
                .foregroundStyle(.gray)
        }
    }
}

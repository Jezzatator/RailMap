//
//  StationLabel.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 18/09/2024.
//


import SwiftUI

struct StationLabel: View {
    let station: String
    
    var body: some View {
        Text(station)
            .multilineTextAlignment(.leading)
            .fontWeight(.semibold)
            .font(.title2)
    }
}

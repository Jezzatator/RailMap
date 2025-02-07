//
//  DateText.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 18/09/2024.
//


import SwiftUI

struct DateText: View {
    let time: String
    let timeRemaining: String
    let arrival: Bool
    
    private var timeRemainingText: String
    
    public init(time: String, timeRemaining: String, arrival: Bool) {
        self.time = time
        self.timeRemaining = timeRemaining
        self.arrival = arrival
        self.timeRemainingText = {
            if timeRemaining == "Déjà parti" {
                return "Déjà parti"
            } else {
                return "\(arrival ? "Arrivé" : "Départ") dans \(timeRemaining)"
            }
        }()
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text(time)
                .fontWeight(.semibold)
                .font(.largeTitle)
            Text(timeRemainingText)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .font(.caption2)
        }
    }
}

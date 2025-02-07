//
//  DepartureStatusView.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 29/11/2024.
//

import SwiftUI
import Helpers

struct DepartureStatusView: View {
    
    var status: DepartureStatus = .unknown
    var time: Date
    var station: String
    var hall: String?
    var platform: String?
    var delayedTime: TimeInterval?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            content
                .padding()
                .background(backgroundColor)
            Divider()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch status {
        case .cancelled:
            statusView(
                title: "Train annulé",
                message: ", veuillez vous rapprocher des agents de voyage",
                color: .red
            )
            
        case .delayed:
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 0.4) {
                    Text("Train retardé")
                        .fontWeight(.bold)
                        .foregroundStyle(.orange.mix(with: .black, by: 0.07))
                    
                    Text(", départ prévu à ")
                        .fontWeight(.semibold)
                    + Text(time.formattedTime())
                        .fontWeight(.semibold)
                        .foregroundStyle(.orange.mix(with: .black, by: 0.07))
                    
                    if let delayedTime = self.delayedTime {
                        Text(" +(\(delayedTime.formattedTimeRemainingDelayed()))")
                            .foregroundStyle(.red.mix(with: .black, by: 0.07))
                            .fontWeight(.semibold)
                    }
                    Spacer(minLength: 0)
                }
                HStack {
                    locationInfo(color: .black)
                }
            }
            
        default:
            HStack {
                HStack {
                    Text("Départ dans ")
                        .fontWeight(.semibold)
                    + Text(time.timeRemainingDescription())
                        .fontWeight(.semibold)
                        .foregroundStyle(.green.mix(with: .black, by: 0.07))
                }
                Spacer(minLength: 0)
                
                primaryLocationView(color: .green)
            }
        }
    }
    
    @ViewBuilder
    private func primaryLocationView(color: Color) -> some View {
        if let platform = platform, let hall = hall {
            VStack(alignment: .trailing, spacing: 0) {
                locationText(title: "Plat.", value: platform, font: .title, color: color)
                locationText(title: "Hall", value: hall, font: .subheadline, color: .black)
            }
        } else if let platform = platform {
            locationText(title: "Plat.", value: platform, font: .title, color: color)
        } else if let hall = hall {
            locationText(title: "Hall", value: hall, font: .title, color: color)
        }
    }
    
    @ViewBuilder
    private func locationInfo(color: Color) -> some View {
        if let platform = platform {
            locationText(title: "Quai", value: platform, font: .subheadline, color: color)
        }
        if let hall = hall {
            locationText(title: "Hall", value: hall, font: .subheadline, color: color)
        }
    }
    
    private func locationText(title: String, value: String, font: Font, color: Color) -> some View {
        HStack(spacing: 4) {
            Text(title)
                .font(font)
                .fontWeight(.semibold)
                .foregroundStyle(color.mix(with: .black, by: 0.07))
            Text(value)
                .font(font)
                .fontWeight(.semibold)
                .foregroundStyle(color.mix(with: .black, by: 0.07))
        }
    }
    
    private func statusView(title: String, message: String, color: Color) -> some View {
        HStack(spacing: 4) {
            Text(title)
                .fontWeight(.bold)
                .foregroundStyle(color.mix(with: .black, by: 0.07))
            + Text(message)
                .fontWeight(.semibold)
            Spacer(minLength: 0)
        }
        .multilineTextAlignment(.leading)
    }
    
    private var backgroundColor: Color {
        switch status {
        case .cancelled: return .red.opacity(0.05)
        case .delayed: return .orange.opacity(0.05)
        default: return .green.opacity(0.05)
        }
    }
    
    enum DepartureStatus {
        case intime, cancelled, delayed, unknown
    }
}

#Preview {
    VStack {
        DepartureStatusView(time: Date.now.addingTimeInterval(5000), station: "Gare de Perpignan")
        DepartureStatusView(time: Date.now.addingTimeInterval(50000), station: "Gare de Perpignan", hall: "3")
        DepartureStatusView(time: Date.now.addingTimeInterval(500000), station: "Gare de Perpignan", hall: "3", platform: "A")
        
        DepartureStatusView(status: .delayed, time: Date.now.addingTimeInterval(5000), station: "Gare de Perpignan")
        DepartureStatusView(status: .delayed, time: Date.now.addingTimeInterval(50000), station: "Gare de Perpignan", hall: "3")
        DepartureStatusView(status: .delayed, time: Date.now.addingTimeInterval(500000), station: "Gare de Perpignan", hall: "3", platform: "A", delayedTime: TimeInterval(floatLiteral: 5000))
        
        DepartureStatusView(status: .cancelled, time: Date.now.addingTimeInterval(5000), station: "Gare de Perpignan")
        DepartureStatusView(status: .cancelled, time: Date.now.addingTimeInterval(50000), station: "Gare de Perpignan", hall: "3")
        DepartureStatusView(status: .cancelled, time: Date.now.addingTimeInterval(500000), station: "Gare de Perpignan", hall: "3", platform: "A")
    }
}

//
//  VerticalTimeline.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 19/09/2024.
//

import SwiftUI

struct VerticalTimeline: View {
    public var timelineConfig: TimelineConfig = .outOfTrip
    public var stationLabel: String = "Station 1"
    public var timeLabel: String = "17:30"
    private var color: UIColor {
        switch timelineConfig {
        case .trip: return .blue
        case .connection: return .gray
        case .outOfTrip: return .gray
        }
    }
    var body: some View {
        HStack(alignment: .top) {
            VStack(spacing: 0) {
                Circle()
                    .fill(.tint)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(.black, lineWidth: 0.5)
                    )
                
                Rectangle()
                    .fill(.tint)
                    .frame(width: 5)
            }
            VStack(alignment: .leading) {
                Text(stationLabel)
                Text(timeLabel)
                    .font(.subheadline)
            }
        }
    }
}

public enum TimelineConfig {
    case trip, connection, outOfTrip
}

#Preview {
    VerticalTimeline()
}

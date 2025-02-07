//
//  JourneyRowViewModel.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 26/07/2024.
//

import Foundation

class JourneyRowViewModel: ObservableObject {
    private let journey: Journey
    
    init(journey: Journey) {
        self.journey = journey
    }
    
    var headsign: String {
        journey.headsign ?? "N/A"
    }
    
    var departureTime: String {
        formatTime(journey.startDate)
    }
    
    var departureDate: String {
        formatDate(journey.startDate)
    }
    
    var departureLabel: String {
        departureStop?.stopinfo?.label ?? "N/A departureLabel"
    }
    
    var arrivalTime: String {
        formatTime(journey.endDate)
    }
    
    var arrivalDate: String {
        formatDate(journey.endDate)
    }
    
    var arrivalLabel: String {
        arrivalStop?.stopinfo?.label ?? "N/A arrivalLabel"
    }
    
    var compagny: String {
        journey.company ?? "N/A company"
    }
    
    var duration: String {
        guard let startDate = journey.startDate, let endDate = journey.endDate else {
            return "N/A"
        }
        let interval = endDate.timeIntervalSince(startDate)
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        return String(format: "%02dh%02d", hours, minutes)
    }
    
    private var departureStop: Stop? {
        return (journey.stops as? Set<Stop>)?.first { $0.status == "departure" }
    }
    
    private var arrivalStop: Stop? {
        return (journey.stops as? Set<Stop>)?.first { $0.status == "arrival" }
    }
    
    private func formatDate(_ date: Date?) -> String {
        guard let date = date else {
            return "Date non disponible"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE. dd MMM."
        return dateFormatter.string(from: date)
    }
    
    private func formatTime(_ date: Date?) -> String {
        guard let date = date else {
            return "Heure non disponible"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}

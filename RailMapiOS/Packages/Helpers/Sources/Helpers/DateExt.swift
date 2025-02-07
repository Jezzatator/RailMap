//
//  DateExt.swift
//  Helpers
//
//  Created by Jérémie Patot on 15/11/2024.
//

import Foundation

//MARK: Date
public extension Date {
    public func formattedTime(with format: String? = "HH:mm") -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = format
        return timeFormatter.string(from: self)
    }
    
    public func timeRemainingDescription() -> String {
        let now = Date()
        let timeInterval = self.timeIntervalSince(now)
        
        if timeInterval > 0 {
            return timeInterval.formattedTimeRemaining()
        } else {
            return "Déjà parti"
        }
    }
    
    public func duration(to endDate: Date) -> String {
        let interval = endDate.timeIntervalSince(self)
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        return String(format: "%02dh%02d", hours, minutes)
    }
}

//MARK: TimeInterval
public extension TimeInterval {
    public func formattedTimeRemaining() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropLeading
        
        return formatter.string(from: self) ?? "Temps inconnu"
    }
    
    public func formattedTimeRemainingDelayed() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropLeading
        
        return formatter.string(from: self) ?? "Temps inconnu"
    }
}

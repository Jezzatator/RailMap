//
//  DateHelpers.swift
//
//
//  Created by Jérémie Patot on 25/05/2024.
//

import Foundation

struct Datehelpers {
    public func convertCalendarToDDMMYY(calendar: Calendar) -> [Date]? {
        guard let activePeriod = calendar.activePeriods.first else {
            return nil // Aucune période active
        }
        
        let weekDaysPattern = calendar.weekPattern
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        // Convertir les dates de début de din en objets Date
        guard let startDate = dateFormatter.date(from: activePeriod.begin),
              let endDate = dateFormatter.date(from: activePeriod.end) else {
            return nil // Impossible de convertir les dates
        }
        
        var currentDate = startDate
        var formattedDates : [Date] = []
        
        let calendar = foundationCalendar.current
        
        while currentDate <= endDate {
            let dayOfWeek = calendar.component(.weekday, from: currentDate)
            
            switch dayOfWeek {
            case 1 where calendar.weekdaySymbols[dayOfWeek - 1] == (weekDaysPattern.sunday ? "Sunday" : "prout") :
                formattedDates.append((currentDate))
            case 2 where calendar.weekdaySymbols[dayOfWeek - 1] == (weekDaysPattern.monday ? "Monday" : "prout") :
                formattedDates.append((currentDate))
            case 3 where calendar.weekdaySymbols[dayOfWeek - 1] == (weekDaysPattern.tuesday ? "Tuesday" : "prout") :
                formattedDates.append((currentDate))
            case 4 where calendar.weekdaySymbols[dayOfWeek - 1] == (weekDaysPattern.wednesday ? "Wednesday" : "prout") :
                formattedDates.append((currentDate))
            case 5 where calendar.weekdaySymbols[dayOfWeek - 1] == (weekDaysPattern.thursday ? "Thursday" : "prout") :
                formattedDates.append((currentDate))
            case 6 where calendar.weekdaySymbols[dayOfWeek - 1] == (weekDaysPattern.friday ? "Friday" : "prout") :
                formattedDates.append((currentDate))
            case 7 where calendar.weekdaySymbols[dayOfWeek - 1] == (weekDaysPattern.saturday ? "Saturday" : "prout") :
                formattedDates.append((currentDate))
            default:
                break
            }
            
            // Passe au jour suivvant
            
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? Date()
            
        }
        
        return formattedDates
        
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter.string(from: date)
    }
    
    func formatDateLettre(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyy"
        
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMMM"
            return outputFormatter.string(from: date)
        } else {
            return "N/A"
        }
    }
    
    func extractName(from input: String) -> String {
        let pattern = ".*:(OCE[\\w ]+)-\\d+"
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            if let match = regex.firstMatch(in: input, options: [], range: NSRange(input.startIndex..., in: input)) {
                let range = Range(match.range(at: 1), in: input)!
                var extractedString = String(input[range])
                
                if extractedString.hasPrefix("OCE") {
                    extractedString = String(extractedString.dropFirst(3))
                }
                
                return extractedString.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        } catch {
            print("Rege Error: \(error)")
        }
        return ""
    }
    
    func formattedHour(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HHmmss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        if let date = formatter.date(from: dateString) {
            return dateFormatter.string(from: date)
        }
        return "Erreur, mauvais format de date"
    }
}

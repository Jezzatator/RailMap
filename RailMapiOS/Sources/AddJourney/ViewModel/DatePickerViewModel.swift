//
//  DatePickerViewModel.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 17/01/2025.
//

import Foundation

class DatePickerViewModel: ObservableObject {
    @Published var dateRows: [DateRow] = []

    init(dateRows: [DateRow]) {
        self.dateRows = dateRows
//        self.dateRows = dateRows.map { row in
//            var mutableRow = row
//            mutableRow.company = self.resolvedCompany(from: row.journey.stopTimes.first!.stopPoint.id)
//            print("Company: \(mutableRow.company)")
//            return mutableRow
//        }
    }
    
    private func resolvedCompany(from stopPoint: String) -> String? {
        let parts = stopPoint.components(separatedBy: " ")
        if parts.count > 1 {
            return parts[1].components(separatedBy: "-").first
        }
        return nil
    }
}

struct DateRow: Identifiable, Hashable {
    let id: UUID = UUID()
    let journeyId: String
    let date: Date
    let journey: VehicleJourney
    var departureStationID: String?
    var arrivalStationID: String?
    var company: String? {
        let parts = self.journey.stopTimes.first?.stopPoint.id.components(separatedBy: " ")
        if let parts = parts {
            if parts.count > 1 {
                return parts[1].components(separatedBy: "-").first
            }
        }
        return nil
    }
   
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: date)
    }
    
    static func == (lhs: DateRow, rhs: DateRow) -> Bool {
        return lhs.id == rhs.id
            && lhs.journeyId == rhs.journeyId
            && lhs.date == rhs.date
    }
        
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(journeyId)
        hasher.combine(date)
    }
}

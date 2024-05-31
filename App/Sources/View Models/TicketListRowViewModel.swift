//
//  TicketListRowViewModel.swift
//  RailMap
//
//  Created by Jérémie - Ada on 24/11/2023.
//

import Foundation

class TicketListRowViewModel: ObservableObject {
    
    func convertFromUTCtoLocalTime(_ timeDateUTC: Date, timeZone: TimeZone = TimeZone.current) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HHmmss"
        dateformatter.timeZone = timeZone
        
        return dateformatter.string(from: timeDateUTC)
        
    }
}

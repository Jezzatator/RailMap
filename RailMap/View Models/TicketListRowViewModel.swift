//
//  TicketListRowViewModel.swift
//  RailMap
//
//  Created by Jérémie - Ada on 24/11/2023.
//

import Foundation

class TicketListRowViewModel: ObservableObject {
    
    func convertFromUTCtoLocalTime(_ timeDateUTC: Date) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HHmmss"
        dateformatter.timeZone = TimeZone.current
        
        return dateformatter.string(from: timeDateUTC)
        
    }
}

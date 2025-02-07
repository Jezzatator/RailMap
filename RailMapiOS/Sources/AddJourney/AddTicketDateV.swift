//
//  AddTicketDateV.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 19/07/2024.
//

import SwiftUI

struct AddTicketDateV: View {
    @State var selectedDate = Date()
    @State var trainNum: String = ""
    
    var body: some View {
        HStack {
            DatePicker(
                "Select a date",
                selection: $selectedDate,
                displayedComponents: .date
            )
            .datePickerStyle(CompactDatePickerStyle())
            .padding()        }
    }
}

#Preview {
    AddTicketDateV()
}

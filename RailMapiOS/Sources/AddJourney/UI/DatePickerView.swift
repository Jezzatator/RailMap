//
//  DatePickerView.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 17/01/2025.
//

import SwiftUI

struct DatePickerView: View {
    @EnvironmentObject var dataController: DataController

    @ObservedObject var viewModel: DatePickerViewModel
    @ObservedObject var router: Router
    
    var onNext: (DateRow) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Choose a date")
                .fontWeight(.bold)
                .font(.title3)
                .foregroundStyle(.gray)
                .padding(.horizontal)
            
            List(viewModel.dateRows) { row in
                HStack {
                    if let company = row.company {
                        Image("icon_\(company.lowercased())_minimal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 44)
                    }
                    VStack(alignment: .leading) {
                        Text(row.journey.headsign)
                            .font(.headline)
                        Text("Detected train journey")
                            .font(.caption)
                    }
                    Spacer()
                    Text(row.formattedDate)
                        .font(.title)
                }
                .padding(.vertical, 4)
                .onTapGesture {
                    onNext(row)
                }
            }
            .listStyle(.plain)
        }
    }
}

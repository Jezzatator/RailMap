//
//  JourneyHeaderView.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 18/09/2024.
//


import SwiftUI

struct JourneyHeaderView: View {
    let company: String?
    let headsign: String?
    let size: CGSize?
    let departureCity: String?
    let arrivalCity: String?
    let departureDate: Date?
    
    public init(company: String? = nil,
                headsign: String? = nil,
                departureCity: String? = nil,
                arrivalCity: String? = nil,
                departureDate: Date? = nil,
                size: CGSize? = nil
    ) {
        self.company = company
        self.headsign = headsign
        self.departureCity = departureCity
        self.arrivalCity = arrivalCity
        self.departureDate = departureDate
        self.size = size
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                CompanyLogo(company, size: size)
                VStack (alignment: .leading) {
                    JourneyInfoView(headsign: headsign, departureDate: departureDate)
                    if let arrivalCity = arrivalCity, let departureCity = departureCity {
                        Text("De \(departureCity) à \(arrivalCity)")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct JourneyInfoView: View {
    let headsign: String?
    let departureDate: Date?
    
    private static let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "EEE, dd MMM"
           return formatter
       }()
    var body: some View {
        HStack(alignment: .top) {
            if let headsign = headsign, let date = departureDate {
                Text(headsign)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                Text("• \(JourneyInfoView.dateFormatter.string(from: date).uppercased())")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
            }
        }
    }
}

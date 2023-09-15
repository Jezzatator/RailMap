//
//  TicketListRowView.swift
//  FlightTicketBrowser
//
//  Created by Takuya Aso on 2021/12/26.
//

import SwiftUI

struct TicketListRowView: View {
    
    let ticketInfo: TicketInfo
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(ticketInfo.date)
                    .font(.custom("Futura-Medium", size: 12.0, relativeTo: .subheadline))
            }
            .frame(width: 40.0, alignment: .leading)
            Divider()
            VStack(alignment: .leading) {
                Text(ticketInfo.departureCode)
                    .font(.custom("Futura-Medium", size: 15.0, relativeTo: .title3))
                    .multilineTextAlignment(.leading)
                Text(ticketInfo.departureTime)
                    .font(.caption2)
                    .fontWeight(.bold)
                Text(ticketInfo.departure)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 8.0)
            Spacer()
            VStack(alignment: .center) {
                Image(systemName: "train.side.front.car")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20.0)
                    .foregroundColor(ticketInfo.trainType.themeColor)
                    .padding(.all, 3)
                Text(ticketInfo.compagny)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .padding(.top,3)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(ticketInfo.destinationCode)
                    .font(.custom("Futura-Medium", size: 15.0, relativeTo: .title3))
                    .multilineTextAlignment(.trailing)
                Text(ticketInfo.arrivalTime)
                    .font(.caption2)
                    .fontWeight(.bold)
                Text(ticketInfo.destination)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8.0)
    }
}

struct TicketListRowView_Previews: PreviewProvider {
    static var previews: some View {
        TicketListRowView(ticketInfo: sampleTicketData[0])
            .frame(height: 80.0)
            .padding(.horizontal)
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}

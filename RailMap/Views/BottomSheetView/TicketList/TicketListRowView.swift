//
//  TicketListRowView.swift
//  FlightTicketBrowser
//
//  Created by Takuya Aso on 2021/12/26.
//

import CoreData
import SwiftUI

struct TicketListRowView: View {
        
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Journey.startDate, ascending: true)]) private var journeys: FetchedResults<Journey>

    let addTicketVM = AddTicketViewModel()
    let vm = TicketListRowViewModel()
    
    var body: some View {


        ForEach(journeys, id: \.self) { journey in
                NavigationLink(destination: TicketDetailView(ticketInfo: journey)) {
                    
                    HStack {
                        VStack(alignment: .leading) {
                            
                            if let startDate = journey.startDate {
                                Text(addTicketVM.formatDate(startDate))
                                    .font(.custom("Futura-Medium", size: 12.0, relativeTo: .subheadline))
                            } else {
                                Text("N/A")
                                    .font(.custom("Futura-Medium", size: 12.0, relativeTo: .subheadline))
                            }
                        }
                        .frame(width: 40.0, alignment: .leading)
                        Divider()
                        VStack(alignment: .leading) {
                            
                            if let stopSet = journey.stops as? Set<Stop>, let departureStop = stopSet.first(where: { $0.status == "departure" }) {
                                
                                Text(departureStop.stopinfo?.label ?? "N/A")
                                    .font(.custom("Futura-Medium", size: 15.0, relativeTo: .title3))
                                    .multilineTextAlignment(.leading)
                                Text(vm.convertFromUTCtoLocalTime(departureStop.departureTimeUTC!))
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                //trouver la ville
                                //                            Text()
                                //                                .font(.caption2)
                                //                                .fontWeight(.semibold)
                                //                                .foregroundColor(.gray)
                            } else {
                                Text("N/A")
                                    .font(.custom("Futura-Medium", size: 15.0, relativeTo: .title3))
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        .padding(.leading, 8.0)
                        Spacer()
                        VStack(alignment: .center) {
                            Image(systemName: "train.side.front.car")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20.0)
                                .foregroundColor(.blue)
                                .padding(.all, 3)
                            Text(journey.compagny)
                                .font(.caption2)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .padding(.top,3)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            
                            if let arrivalStop = journey.stops?.index(where: { $0.status == "arrival" }) {
                                
                                
                                Text(arrivalStop.stopinfo.label)
                                    .font(.custom("Futura-Medium", size: 15.0, relativeTo: .title3))
                                    .multilineTextAlignment(.trailing)
                                Text(vm.convertFromUTCtoLocalTime(arrivalStop.arrivalTimeUTC))
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                // trouver la ville d'arrivée
                                //                            Text(ticketInfo.destination)
                                //                            .font(.caption2)
                                //                            .fontWeight(.semibold)
                                //                            .foregroundColor(.gray)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8.0)
            }
        }
    }
}

//struct TicketListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TicketListRowView(ticketInfo: sampleTicketData[0])
//            .frame(height: 80.0)
//            .padding(.horizontal)
//            .previewLayout(PreviewLayout.sizeThatFits)
//    }
//}

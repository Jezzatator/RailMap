//
//  TicketDetailMainView.swift
//  FlightTicketBrowser
//
//  Created by Takuya Aso on 2021/12/30.
//

import SwiftUI

struct TicketDetailMainView: View {
    
 //   let ticketInfo: TicketInfo
        
    var body: some View {
        VStack(spacing: 16.0) {
            HStack(spacing: .zero) {
                BlockView(key: "TRAIN NUM", value: "num", rows: 3)
                Divider()
                BlockView(key: "HALL", value: "hall", rows: 3)
                Divider()
                BlockView(key: "VOIE", value: "voie", rows: 3)
            }
            Divider()
            HStack(spacing: .zero) {
                BlockView(key: "DATE", value: "date", rows: 3)
                Divider()
                BlockView(key: "DEPARTURE TIME", value: "heure", rows: 3)
                Divider()
                BlockView(key: "SEAT", value: "siege", rows: 3)
            }
            Divider()
            HStack(spacing: .zero) {
                BlockView(key: "PASSENGER", value: "passager", rows: 2)
                Divider()
                BlockView(key: "PASSPORT", value: "passport", rows: 2)
            }
            Divider()
            HStack(spacing: .zero) {
                BlockView(key: "E-TICKET NUM", value: "eticket num", rows: 2)
                Divider()
                BlockView(key: "BOOKING CODE", value: "booking code", rows: 2)
            }
            Divider()
            HStack(spacing: .zero) {
                BlockView(key: "PAYMENT METHOD", value: "method", rows: 2)
                Divider()
                BlockView(key: "PRICE", value: "price", rows: 2)
            }
            // Pattern 1
            //Image(uiImage: UIImage(data: BarcodeGenerator.generate(barcodeStr: ticketInfo.eTicketNumber + ticketInfo.bookingCode)!)!)
            // Pattern 2 (IMO: Better way)
            //Image(uiImage: BarcodeGenerator.generateNew(barcodeStr: ticketInfo.eTicketNumber + ticketInfo.bookingCode)!)
   //             .resizable()
   //             .interpolation(.none)
   //             .scaledToFill()
  //              .frame(height: 24.0)
//                .padding(.vertical, 20.0)
        }
        .padding(.horizontal, 20.0)
        .padding(.top, 12.0)
        .padding(.bottom, 20.0)
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.tertiarySystemBackground))
        .cornerRadius(12.0, corners: [.bottomLeft, .bottomRight])
        .toolbar {
            Button {
                //showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
}

struct TicketDetailMainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

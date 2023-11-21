//
//  Section1AddTicketView.swift
//  RailMap
//
//  Created by Jérémie - Ada on 15/09/2023.
//

import SwiftUI

struct Section1AddTicketView: View {
       
    @StateObject var viewModel: AddTicketViewModel
    @EnvironmentObject var addTicketInfoVM: AddTicketInfo
    
    @Binding var trainNum: String
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Train's number")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                Spacer()
            }
            
            TextField("Enter your train number", text: $trainNum)
                .foregroundColor(.black)
                .frame(height: 44, alignment: .center)
                .background(.thinMaterial)
                .cornerRadius(10)
                .keyboardType(.namePhonePad)
                .submitLabel(.search)
                .scrollDismissesKeyboard(.interactively)
        }
        .padding(.horizontal)
        .onChange(of: trainNum) {
            Task {
                await viewModel.fetchHeadsignAddTicket(headsign: trainNum)
            }
        }
    }
}

#Preview {
    AddTicket()
        .environmentObject(AddTicketInfo())
}

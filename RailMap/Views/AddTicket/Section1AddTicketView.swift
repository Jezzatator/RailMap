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
        
        HStack {
            Text("Numéro de Train")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
                .padding(.leading)
            Spacer()
        }
        
        TextField("Entrez votre numéro de train", text: $trainNum)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .frame(height: 44, alignment: .center)
                        .background(.thinMaterial)
                        .cornerRadius(10)
                        .keyboardType(.namePhonePad)
                        .submitLabel(.search)
                        .onSubmit {
                            Task {
                                await viewModel.fetchHeadsignAddTicket(headsign: trainNum)
                            }
                        }
                        .scrollDismissesKeyboard(.interactively)
    
    }
}

#Preview {
    ContentView()
}

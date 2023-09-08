//
//  BottomSheetViewLarge.swift
//  RailMap
//
//  Created by Jérémie - Ada on 08/09/2023.
//

import Foundation

import SwiftUI

struct BottomSheetViewLarge: View {
    @StateObject private var viewModel = TicketListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("My Journeys")
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .font(.title)
                    Spacer()
                }
                TextField("Search Journey", text:
                        .constant(""))
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.ultraThinMaterial)
                }
                    List {
                        Section {
                            ForEach(viewModel.ticketList.indices, id: \.self) { index in
                                NavigationLink(destination: TicketDetailView(ticketInfo: viewModel.ticketList[index])) {
                                    TicketListRowView(ticketInfo: viewModel.ticketList[index])
                                }
                            }
                        } footer: {
                            TicketListFooterView()
                        }
                    }
                    .listStyle(PlainListStyle())
                .onAppear {
                    viewModel.fetchTicketList()
                }
                Spacer()
            }
            .padding()
            .padding(.top)
        }
    }
}

#Preview {
    ContentView()
}

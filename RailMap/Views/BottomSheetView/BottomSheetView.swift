//
//  BottomSheetViewLarge.swift
//  RailMap
//
//  Created by Jérémie - Ada on 08/09/2023.
//

import Foundation

import SwiftUI

struct BottomSheetViewLarge: View {
    @State private var showingSheet = false
    @StateObject private var viewModel = TicketListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Group {
                    HStack {
                        Text("My Journeys")
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .font(.title)
                        Spacer()
                        Button(action: {showingSheet.toggle()}, label: {
                            Image(systemName: "plus").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        })
                    }
                    TextField("Search Journey", text:
                            .constant(""))
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.ultraThinMaterial)
                    }
                }
                .padding(.horizontal, 15)
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
            .padding(.top)
        }
        .fullScreenCover(isPresented: $showingSheet, content: {
            AddTicket()
        })
    }
}

#Preview {
    ContentView()
}

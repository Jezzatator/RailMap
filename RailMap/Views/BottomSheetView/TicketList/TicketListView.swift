//
//  TicketListView.swift
//  FlightTicketBrowser
//
//  Created by Takuya Aso on 2021/12/26.
//

import SwiftUI

struct TicketListView: View {
    
    @StateObject private var viewModel = TicketListViewModel()
    
    @Binding var sheetSize: PresentationDetent
    
    var body: some View {
        NavigationView {
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
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.fetchTicketList()
        }
    }
}

struct TicketListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

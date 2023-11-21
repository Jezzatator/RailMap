//
//  RailMapApp.swift
//  RailMap
//
//  Created by Jérémie - Ada on 02/09/2023.
//

import SwiftUI

@main
struct RailMapApp: App {
    
    @StateObject private var dataController = DataController()
    @StateObject private var addTicketInfo = AddTicketInfo()


    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(addTicketInfo)

        }
    }
}

//
//  RailMapApp.swift
//  RailMap
//
//  Created by Jérémie - Ada on 02/09/2023.
//

import SwiftUI
import SwiftData

@main
struct RailMapApp: App {
    
    @StateObject var addTicketInfoVM = AddTicketInfo()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(addTicketInfoVM)
        }
    }
}

//
//  RailMapApp.swift
//  RailMap
//
//  Created by Jérémie - Ada on 02/09/2023.
//

import SwiftUI

@main
struct RailMapApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, DataController.shared.viewContext)
        }
    }
}

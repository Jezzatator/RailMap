//
//  ContentView.swift
//  RailMap
//
//  Created by Jérémie - Ada on 02/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingCredits = true
    
    var body: some View {
        ZStack {
            MapView()
                .sheet(isPresented: $showingCredits) {
                    BottomSheetViewLarge()
                        .presentationDetents([.height(250),.height(500),.large])
                        .presentationBackgroundInteraction(
                            .enabled)
                        .interactiveDismissDisabled()
                        .ignoresSafeArea()
                }
        }
    }
}

#Preview {
    ContentView()
}

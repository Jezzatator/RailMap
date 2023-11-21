//
//  ContentView.swift
//  RailMap
//
//  Created by Jérémie - Ada on 02/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isSheetPresented = true
    @State private var sheetSize: PresentationDetent = .height(250)

    var body: some View {
        ZStack {
            MapView()
                .sheet(isPresented: $isSheetPresented) {
                    BottomSheetViewLarge(sheetSize: $sheetSize)
                        .presentationDetents([.height(250),.height(500),.large], selection: $sheetSize)
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

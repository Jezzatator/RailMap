//
//  ContentView.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 12/07/2024.
//

import SwiftUI
import MapKit

public struct ContentView: View {
    public init() {}
    
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    
    @State private var isSheetPresented = true
    @State private var sheetSize: PresentationDetent = .fraction(0.3)
    
    @StateObject private var router = Router()

    public var body: some View {
        Group {
            if UIDevice.current.userInterfaceIdiom == .phone {
                iPhoneLayout(isSheetPresented: $isSheetPresented, sheetSize: $sheetSize, router: router)
            } else {
                iPadLayout(sheetSize: $sheetSize, router: router)
            }
        }
        .onAppear() {
            dataController.deleteAllObjects(of: "Journey", context: moc)
        }
    }
}

public struct iPhoneLayout: View {
    @EnvironmentObject var dataController: DataController

    @Binding var isSheetPresented: Bool
    @Binding var sheetSize: PresentationDetent
    @ObservedObject var router: Router

    public var body: some View {
        ZStack {
            Map()
                .sheet(isPresented: $isSheetPresented) {
                    BottomSheetView(router: router, sheetSize: $sheetSize)
                        .padding(.top)
                        .presentationDetents([.fraction(0.3), .medium, .large], selection: $sheetSize)
                        .presentationBackgroundInteraction(.enabled)
                        .interactiveDismissDisabled()
                        .ignoresSafeArea()
                }
        }
    }
}

public struct iPadLayout: View {
    @Binding var sheetSize: PresentationDetent
    @ObservedObject var router: Router

    public var body: some View {
        NavigationSplitView {
            BottomSheetView(router: router, sheetSize: $sheetSize)
                .listStyle(SidebarListStyle())
                .frame(minWidth: 200)
        } detail: {
            Map()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

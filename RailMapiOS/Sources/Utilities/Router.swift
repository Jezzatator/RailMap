//
//  Router.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 19/01/2025.
//

import Foundation
import SwiftUI
import CoreData

class Router: ObservableObject {
    @Published var path: [Flow] = [] {
        didSet {
            print("Router path updated:", path)
        }
    }

    enum Flow: Hashable {
        case journeys
        case addTicket(searchText: String?)
        case journeyDetails(objectID: NSManagedObjectID)
        case datePicker(dateRows: [DateRow])
        case stationPicker(DateRow)
        case confirmation(DateRow)
    }

    func navigate(to flow: Flow) {
        path.append(flow)
        print("Navigated to:", flow)
        print("Current Path:", path)
    }

    func navigateBack() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func navigateToRoot() {
        path.removeAll()
    }
}

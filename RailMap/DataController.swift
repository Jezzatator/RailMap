//
//  DataController.swift
//  RailMap
//
//  Created by Jérémie - Ada on 17/11/2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "RailMap")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Date saved.")
        } catch {
            print("Error: data not saved")
        }
    }
}

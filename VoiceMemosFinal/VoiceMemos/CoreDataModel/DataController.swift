//
//  DataController.swift
//  VoiceMemos
//
//  Created by Alessia Andrisani on 11/12/21.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "VoiceMemos")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}

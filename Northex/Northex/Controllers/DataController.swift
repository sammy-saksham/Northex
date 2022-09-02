//
//  Data Controller.swift
//  Northex
//
//  Created by Saksham Jain on 16/05/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    var container = NSPersistentContainer(name: "DataModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error laoding CoreData: \(error.localizedDescription)")
            }
        }
    }
}

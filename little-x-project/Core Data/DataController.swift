//
//  DataController.swift
//  little-x-project
//
//  Created by Segal GBENOU on 19/01/2025.
//

import Foundation
import CoreData

// permet d'interagir avec la bd
// un controller = un contexte
class DataController: ObservableObject {
    // représentation de la bd qu'on va modifier
    let container: NSPersistentContainer
    
    static let shared = DataController()
    // contexte pour la preview
    static let preview = DataController(inMemory: true)
    
    init(inMemory: Bool = false) {
        self.container = NSPersistentContainer(name: "MyDatabase")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(filePath: "/dev/null")
        }
        
        container.loadPersistentStores{description, error in
            if let error {
                print("Failed to load persistent store: \(error.localizedDescription)")
            }
            
        }
    }
}

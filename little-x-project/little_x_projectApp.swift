//
//  little_x_projectApp.swift
//  little-x-project
//
//  Created by Segal GBENOU on 19/01/2025.
//

import SwiftUI

@main
struct little_x_projectApp: App {
    // transmettre en tant que variable d'environnement
    @StateObject private var dataController = DataController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                \.managedObjectContext,
                 dataController.container.viewContext
            )
        }
    }
}

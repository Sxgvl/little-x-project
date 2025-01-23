//
//  ContentView.swift
//  little-x-project
//
//  Created by Segal GBENOU on 19/01/2025.
//

import SwiftUI

struct ContentView: View {
    // voir le contexte comme une copie conforme de la base de données
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

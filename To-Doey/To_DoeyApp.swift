//
//  To_DoeyApp.swift
//  To-Doey
//
//  Created by Deonte Kilgore on 6/19/23.
//

import SwiftUI
import SwiftData

@main
struct To_DoeyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            // Step 2: Create a container for storing the provided model type.
                .modelContainer(for: ToDoItem.self)
        }
    }
}

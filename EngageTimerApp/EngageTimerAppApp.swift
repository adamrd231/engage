//
//  EngageTimerAppApp.swift
//  EngageTimerApp
//
//  Created by Adam Reed on 3/6/24.
//

import SwiftUI
import SwiftData

@main
struct EngageTimerAppApp: App {
    init() {
        UITableViewCell.appearance().backgroundColor = UIColor.clear
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            EngageTimer.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

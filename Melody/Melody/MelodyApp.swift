//
//  MelodyApp.swift
//  Melody
//
//  Created by Albert Kornas on 11/4/20.
//

import SwiftUI

@main
struct MelodyApp: App {
    let persistenceController = PersistenceController.shared
    let melodyModel = MelodyModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(melodyModel)
        }
    }
}

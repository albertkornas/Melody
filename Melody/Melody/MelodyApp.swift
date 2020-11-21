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
    @State var str = "hello"
    var body: some Scene {
        WindowGroup {
            ContentView(selection: $str)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(melodyModel)
        }
    }
}

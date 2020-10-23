//
//  ClassicsApp.swift
//  Classics
//
//  Created by Albert Kornas on 10/19/20.
//

import SwiftUI

@main
struct ClassicsApp: App {
    let classicModel = ClassicModel()
    
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(classicModel)
        }.onChange(of: scenePhase) {phase in
            switch phase {
            case .inactive:
                classicModel.saveData()
            default:
                break
            }
        }
    }
}

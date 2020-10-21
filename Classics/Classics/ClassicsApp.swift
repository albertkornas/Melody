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
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(classicModel)
        }
    }
}

//
//  MainTabView.swift
//  Melody
//
//  Created by Albert Kornas on 11/21/20.
//

import SwiftUI

struct MainTabView: View {
    @Binding var selection: String
    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tag(0)
                .tabItem {
                    VStack {
                        Image(systemName: "music.note")
                        Text("Welcome")
                    }
                }
            LoginView()
                .tag(1)
                .tabItem {
                    VStack {
                        Image(systemName: "music.note")
                        Text("Player")
                    }
                }
        }
        .accentColor(.blue)
    }
}
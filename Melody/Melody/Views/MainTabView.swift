//
//  MainTabView.swift
//  Melody
//
//  Created by Albert Kornas on 11/21/20.
//

import SwiftUI
import MediaPlayer

struct MainTabView: View {
    @Binding var selection: String
    @State private var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    
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
            FinderView()
                .tag(1)
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
        }
        .accentColor(.blue)
    }
}

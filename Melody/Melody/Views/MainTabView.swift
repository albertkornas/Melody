//
//  MainTabView.swift
//  Melody
//
//  Created by Albert Kornas on 11/21/20.
//

import SwiftUI
import MediaPlayer
import StoreKit

struct MainTabView: View {
    @Binding var selection: String
    @State private var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    @EnvironmentObject var melodyModel : MelodyModel
    var body: some View {
        TabView(selection: $selection) {
            PlaylistListView(playlists: $melodyModel.playlists)
                .onAppear() {
                    SKCloudServiceController.requestAuthorization { (status) in
                        if status == .authorized {
                            melodyModel.fetchUserPlaylists()
                        }
                    }
                }
                .tag(0)
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
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

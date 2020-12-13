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
    @EnvironmentObject var melodyModel : MelodyModel
    var body: some View {
        TabView(selection: $selection) {
            PlaylistListView(playlists: $melodyModel.playlists)

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
            
            /*SongPlayerView(song: melodyModel.musicPlayer.nowPlayingItem, musicPlayer: <#T##Binding<MPMusicPlayerController>#>, showPlayerView: <#T##Binding<Bool>#>, playingMusic: <#T##Bool#>)
                .tag(2)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }*/
        }
        .accentColor(.blue)
    }
}

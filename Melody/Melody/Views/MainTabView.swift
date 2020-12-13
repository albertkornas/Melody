//
//  MainTabView.swift
//  Melody
//
//  Created by Albert Kornas on 11/21/20.
//

import SwiftUI
import MediaPlayer
import StoreKit

enum TabState {
    case home
    case searching
}
struct MainTabView: View {
    @State var selection: Int
    @EnvironmentObject var melodyModel : MelodyModel
    var body: some View {
        TabView(selection: $selection) {
            PlaylistListView(playlists: $melodyModel.playlists)

                .tag(TabState.home)
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
            
            FinderView()
                .tag(TabState.searching)
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

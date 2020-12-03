//
//  PlaylistListView.swift
//  Melody
//
//  Created by Albert Kornas on 11/12/20.
//

import SwiftUI
import MediaPlayer

struct PlaylistListView: View {
    @EnvironmentObject var model: MelodyModel
    @Binding var playlists : [Playlist]
    @State private var mediaPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    var body: some View {
        VStack {
            Text("Playlists")
                .fontWeight(.bold)
            VStack {
                ForEach(playlists.indices, id:\.self) {index in
                    if (playlists[index].tracks != nil) {
                        HStack {
                            Text(playlists[index].attributes.name)
                                .fontWeight(.bold)
                                .rotationEffect(Angle(degrees: -90))
                                .fixedSize(horizontal: true, vertical: false)
            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(playlists[0].tracks!, id:\.self) { track in
                                        NavigationLink(destination: PlaylistDetailView(playlist: $playlists[index], mediaPlayer: $mediaPlayer)) {
                                        imageArtwork(song: track)
                                    }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct imageArtwork: View {
    var song: Song
    var body: some View {
        VStack {
            CategoryItem(withArtworkURL: song.artworkURL?["url"] as! String, withSize: 155.0)
            Text(song.trackName ?? "")
                .foregroundColor(.white)
        }
    }
}

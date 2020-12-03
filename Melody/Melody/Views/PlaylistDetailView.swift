//
//  PlaylistDetailView.swift
//  Melody
//
//  Created by Albert Kornas on 11/16/20.
//

import SwiftUI
import MediaPlayer

struct PlaylistDetailView: View {
    @Binding var playlist: Playlist
    @Binding var mediaPlayer: MPMusicPlayerController
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("  \(playlist.attributes.name)")
                .font(.headline)
            List {
                ForEach(playlist.tracks!.indices, id:\.self) { index in
                    SongRowView(currentSong: playlist.tracks![index], mediaPlayer: $mediaPlayer)
                }
            }
        }
    }
}

struct SongRowView: View {
    let currentSong: Song
    @State var showPlayerView = false
    @Binding var mediaPlayer: MPMusicPlayerController
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(currentSong.trackName ?? "")
                    .font(.headline)
                Text(currentSong.artistName ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Button(action: {
                let songId : String = currentSong.playParams!["catalogId"] as! String
                self.mediaPlayer.setQueue(with: [songId])
                self.mediaPlayer.play()
                self.showPlayerView.toggle()
            }) {
                Image(systemName: "play.fill")
                    .foregroundColor(.green)
            }.sheet(isPresented: $showPlayerView) {
                NavigationView {
                    SongPlayerView(song: currentSong, musicPlayer: $mediaPlayer, showPlayerView: self.$showPlayerView, playingMusic: mediaPlayer.playbackState == .playing ? true : false)
                }
            }
        }
    }
}

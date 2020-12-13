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
    @EnvironmentObject var model: MelodyModel
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
                if let mediaPlaying = mediaPlayer.nowPlayingItem {
                    self.model.removeFromQueue(songId: mediaPlaying.playbackStoreID)
                }
                var songId = currentSong.playParams?["catalogId"]
                if songId == nil {
                    songId = currentSong.playParams?["id"]
                }
                model.addToQueue(withSongId: songId as! String, toBeginning: true)
                mediaPlayer.play()
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

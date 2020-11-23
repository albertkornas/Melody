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
            ForEach(playlist.tracks!, id:\.self) { song in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(song.trackName ?? "")
                                .font(.headline)
                            Text(song.artistName ?? "")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            let songId : String = song.playParams!["catalogId"] as! String
                            if (self.mediaPlayer.playbackState == .playing) {
                                self.mediaPlayer.pause()
                            } else {
                                self.mediaPlayer.setQueue(with: [songId ])
                                self.mediaPlayer.play()
                            }
                        }) {
                            Image(systemName: "play.fill")
                                .foregroundColor(.green)
                        }
                    }
                }
        }
        }
    }
}

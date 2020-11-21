//
//  PlaylistDetailView.swift
//  Melody
//
//  Created by Albert Kornas on 11/16/20.
//

import SwiftUI

struct PlaylistDetailView: View {
    @Binding var playlist: Playlist
    
    
    var body: some View {
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
                            print("Click")
                        }) {
                            Image(systemName: "play.fill")
                                .foregroundColor(.green)
                        }
                    }
                }
        }
    }
}

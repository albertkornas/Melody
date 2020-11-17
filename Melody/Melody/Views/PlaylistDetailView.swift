//
//  PlaylistDetailView.swift
//  Melody
//
//  Created by Albert Kornas on 11/16/20.
//

import SwiftUI

struct PlaylistDetailView: View {
    @Binding var songs: [Song]
    
    
    var body: some View {
        List {
            ForEach(songs, id:\.self) { song in
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


struct PlaylistDetailView_Previews: PreviewProvider {
    @State static var songArray = [Song(albumName: "A", artistName: "The Weeknd", artworkURL: "L", trackName: "Blinding Lights")]
    static var previews: some View {
        PlaylistDetailView(songs: $songArray)
    }
}

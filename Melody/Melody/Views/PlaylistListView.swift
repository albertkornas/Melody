//
//  PlaylistListView.swift
//  Melody
//
//  Created by Albert Kornas on 11/12/20.
//

import SwiftUI

struct PlaylistListView: View {
    @Binding var playlists : [Playlist]

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
                            .rotationEffect(Angle(degrees: 90))
                            .fixedSize(horizontal: true, vertical: false)

                            ForEach(playlists[0].tracks!, id:\.self) { track in
                                imageArtwork(song: track)
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
            CategoryItem(withArtworkURL: song.artworkURL?["url"] as! String, withSong: song)
            Text(song.trackName ?? "")
        }
    }
}

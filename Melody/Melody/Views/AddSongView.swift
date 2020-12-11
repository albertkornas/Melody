//
//  AddSongView.swift
//  Melody
//
//  Created by Albert Kornas on 12/9/20.
//

import SwiftUI

struct AddSongView: View {
    @EnvironmentObject var model: MelodyModel
    @Binding var showAddSongView: Bool
    let song: Song
    
    var body: some View {
            List {
                ForEach(model.playlists.indices, id: \.self) { index in
                    playlistRowView(showAddSongView: $showAddSongView, playlistTitle: model.playlists[index].attributes.name, amountOfTracks: model.playlists[index].tracks?.count, playlistIndex: index, newSong: song)
                }
            }.navigationBarTitle("Add to Playlist", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.showAddSongView = false
            }) {
                Text("Cancel")
            })
    }
}

struct playlistRowView: View {
    @EnvironmentObject var model: MelodyModel
    @Binding var showAddSongView: Bool
    
    let playlistTitle: String
    let amountOfTracks: Int?
    let playlistIndex: Int
    let newSong: Song
    
    var body: some View {
        VStack {
            Button(action: {
                model.appendSongToPlaylist(withIndex: playlistIndex, withSong: newSong)
                self.showAddSongView = false
            }) {
                Text(playlistTitle)
                    .font(.headline)
                Text(String(amountOfTracks ?? 0))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

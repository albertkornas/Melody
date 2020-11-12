//
//  PlaylistListView.swift
//  Melody
//
//  Created by Albert Kornas on 11/12/20.
//

import SwiftUI

struct PlaylistListView: View {
    @Binding var playlists : [Song]
    var body: some View {
        ForEach(playlists.indices, id:\.self) {index in
            NavigationLink(destination: SongPlayerView(song: self.$playlists[0])) {
                SongRowView(song: self.$playlists[0])
            }
        }
    }
}

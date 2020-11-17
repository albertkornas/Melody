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
                    Text(playlists[index].attributes.name)
                }
            }
        }
    }
}

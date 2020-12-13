//
//  SongOptionsView.swift
//  Melody
//
//  Created by Albert Kornas on 12/11/20.
//

import SwiftUI

struct SongOptionsView: View {
    @EnvironmentObject var model: MelodyModel
    let song: Song
    @State var showAddSongView = false
    var body: some View {
        GeometryReader { window in
            VStack {
                CategoryItem(withArtworkURL: song.artworkURL?["url"] as! String, withSize: abs(window.size.width-30))
                    .padding(20)
                List {
                    Button(action: {
                        
                        self.showAddSongView.toggle()
                    }) {
                        Text("Add to Playlist")
                    }.sheet(isPresented: $showAddSongView) {
                        NavigationView {
                            AddSongView(showAddSongView: self.$showAddSongView, song: song)
                                .environmentObject(model)
                       }
                    }
                    
                    Button(action: {
                        let songId : String = song.playParams!["id"] as! String
                        model.addToQueue(withSongId: songId, toBeginning: false)
                    }) {
                        Text("Add to Queue")
                    }
                }
            }
        }
    }
}

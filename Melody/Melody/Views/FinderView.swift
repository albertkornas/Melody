//
//  FinderView.swift
//  Melody
//
//  Created by Albert Kornas on 12/6/20.
//

import SwiftUI
import StoreKit
import MediaPlayer

struct FinderView: View {
    @EnvironmentObject var model: MelodyModel
    @State private var results = [Song]()
    @State private var finderText = ""
    @State var showPlayerView = false
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $finderText, onEditingChanged: {_ in
                    if self.finderText.isEmpty {
                        self.results = []
                    } else {
                        SKCloudServiceController.requestAuthorization { (status) in
                                    if status == .authorized {
                                        model.searchMusic(input: finderText) { output in
                                            self.results = output
                                        }
                                    }
                                }
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    finderText = ""
                    self.results = []
                }) {
                    Text("Cancel")
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }.padding(20)

            
            List {
                ForEach(self.results.indices, id:\.self) { song in
                    RowView(song: self.results[song], mediaPlayer: $model.musicPlayer)
                }
            }
        }
    }
}

struct RowView: View {
    let song: Song
    @Binding var mediaPlayer : MPMusicPlayerController
    @State private var showPlayerView = false
    
    var body: some View {
        GeometryReader { proxy in
        HStack {
            CategoryItem(withArtworkURL: song.artworkURL?["url"] as! String, withSize: abs(proxy.size.height*0.90))
            
            VStack(alignment: .leading) {
                Button(action: {
                    let songId : String = song.playParams!["id"] as! String
                    mediaPlayer.setQueue(with: [songId])
                    mediaPlayer.play()
                    self.showPlayerView.toggle()
                }) {
                Text(song.trackName ?? "")
                    .font(.headline)
                }.sheet(isPresented: $showPlayerView) {
                    NavigationView {
                        SongPlayerView(song: song, musicPlayer: $mediaPlayer, showPlayerView: self.$showPlayerView, playingMusic: true)
                    }
                }
                Text(song.artistName ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

        }
        }
    }
}

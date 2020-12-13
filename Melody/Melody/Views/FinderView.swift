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
    @EnvironmentObject var model: MelodyModel
    @Binding var mediaPlayer : MPMusicPlayerController
    @State private var showPlayerView = false
    @State private var showAddSongView = false
    @State private var showOptionsView = false
    
    var body: some View {
        GeometryReader { proxy in
            HStack {
                CategoryItem(withArtworkURL: song.artworkURL?["url"] as! String, withSize: abs(proxy.size.height*0.90))
                HStack {
                    VStack(alignment: .leading) {
                        Button(action: {
                            var songId = song.playParams?["catalogId"]
                            if songId == nil {
                                songId = song.playParams?["id"]
                            }
                            model.addToQueue(withSongId: songId as! String, toBeginning: true)
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
                    Spacer()
                    //Add this song to a certain playlist
                    Button(action: {
                        self.showOptionsView.toggle()
                    }) {
                        Image(systemName: "text.badge.plus")
                    }.sheet(isPresented: $showOptionsView) {
                        SongOptionsView(song: song)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
        }
    }
}

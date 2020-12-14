//
//  PlaylistListView.swift
//  Melody
//
//  Created by Albert Kornas on 11/12/20.
//

import SwiftUI
import MediaPlayer

struct PlaylistListView: View {
    @EnvironmentObject var model: MelodyModel
    @Binding var playlists : [Playlist]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Recently Played")) {
                    RecentlyPlayed()
                }
                
                Section(header: Text("Charts")) {
                    VStack(alignment: .leading) {
                        Text("Song Charts")
                            .font(.title)
                        SongCharts()
                    }
                }
            }.navigationBarTitle("Home")
        }.onAppear() {
            self.model.loadChart()
        }
    }
}

enum ChartIdentifier: Int {
    case globalSongs = 0
    case usSongs = 1
    case globalAlbums = 2
    case usAlbums = 3
}

struct ChartCard: View {
    @EnvironmentObject var model: MelodyModel
    let cardName : String
    let imageName: String
    let chartId: ChartIdentifier
    var body: some View {
        VStack {
            
                    Image(imageName)
                        .resizable()
                        .frame(width: 155, height: 155)
                    Text(self.cardName)
                        .font(.subheadline)
            
        }.frame(width: 180)
    }
}

struct SongCharts: View {
    @EnvironmentObject var model: MelodyModel
    var body: some View {
        HStack {
            NavigationLink(destination: PlaylistDetailView(playlist: $model.chart, mediaPlayer: $model.musicPlayer)) {
                ChartCard(cardName: "United States Top Songs", imageName: "Top50USA", chartId: ChartIdentifier.usSongs)
            }
        }
            
    }
}

struct AlbumCharts: View {
    var body: some View {
        HStack {
            ChartCard(cardName: "Top Albums Global", imageName: "TopAlbumsGlobal", chartId: ChartIdentifier.globalAlbums)
            ChartCard(cardName: "Top Albums United States", imageName: "TopAlbumsUSA", chartId: ChartIdentifier.usAlbums)
        }
    }
}

struct RecentlyPlayed: View {
    @EnvironmentObject var model: MelodyModel
    
    var body: some View {
        ForEach(model.playlists.indices, id:\.self) {index in
            if (model.playlists[index].tracks != nil) {
                HStack {
                    Text(model.playlists[index].attributes.name)
                        .fontWeight(.bold)
                        .rotationEffect(Angle(degrees: -90))
                        
                        .fixedSize(horizontal: true, vertical: false)
                        .frame(width: 30.0)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(model.playlists[index].tracks!, id:\.self) { track in
                                NavigationLink(destination: PlaylistDetailView(playlist: $model.playlists[index], mediaPlayer: $model.musicPlayer)) {
                                imageArtwork(song: track)
                                    .frame(width: 190.0, height: 180)
                            }
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
            CategoryItem(withArtworkURL: song.artworkURL?["url"] as! String, withSize: 155.0)
            Text(song.trackName ?? "")
                .foregroundColor(.white)
                .font(.caption)
        }
    }
}

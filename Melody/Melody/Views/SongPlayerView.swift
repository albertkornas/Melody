//
//  SongPlayerView.swift
//  Melody
//
//  Created by Albert Kornas on 11/12/20.
//

import SwiftUI
import MediaPlayer

struct SongPlayerView: View {
    @EnvironmentObject var model: MelodyModel
    let song : Song?
    @Binding var musicPlayer: MPMusicPlayerController
    @Binding var showPlayerView: Bool
    @State var playingMusic : Bool
    @State private var songProgress = 0.0
    
    var body: some View {
        if (song == nil) {
            emptyView()
        } else {
            GeometryReader { window in
                VStack(alignment: .center, spacing: 30) {
                    CategoryItem(withArtworkURL: song?.artworkURL?["url"] as! String, withSize: abs(window.size.width-30))
                        .padding(20)

                    VStack(alignment: .leading, spacing: 7.5) {
                        Text(self.musicPlayer.nowPlayingItem?.title ?? "")
                            .font(.title)
                            .padding(.leading, 5)
                        Text(self.musicPlayer.nowPlayingItem?.artist ?? "")
                            .font(.subheadline)
                            .padding(.leading, 5)
                        
                        let durationInSecs = (song?.duration ?? 0)/1000
                        
                        VStack(spacing:2) {
                            
                            Slider(value: $songProgress, in:0...durationInSecs, onEditingChanged: { editing in
                                musicPlayer.currentPlaybackTime = songProgress
                                if (editing == true) {
                                    musicPlayer.pause()
                                } else {
                                    if (playingMusic == true) {
                                        musicPlayer.play()
                                    }
                                }
                            }).foregroundColor(.white)
                            .frame(width: window.size.width*0.9)
                            .padding(5)
                            HStack(spacing: window.size.width*0.7) {
                                Text(String(format: "%.01d:%.02d", Int(songProgress/60), Int(songProgress.truncatingRemainder(dividingBy: 60))))
                                    .font(.footnote)
                                    .padding(.leading, 5)
                                Text(String(format: "%.01d:%.02d", Int(durationInSecs/60), Int(durationInSecs.truncatingRemainder(dividingBy: 60))))
                                    .font(.footnote)
                                    .padding(.trailing, 5)
                            }
                        }
                    }
                    
                    SongControls(musicPlayer: self.$musicPlayer, playingMusic: self.$playingMusic)
                        
                    .navigationBarTitle(Text("Playing Now"), displayMode: .inline)
                    .navigationBarItems(
                        trailing: Button(action: {
                        self.showPlayerView = false
                    }) {
                        Image(systemName: "chevron.down")
                            .foregroundColor(.white)
                    }
                    
                    )
                }
            }.onAppear() {
                DispatchQueue.global(qos: .background).async {
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {_ in
                        songProgress = musicPlayer.currentPlaybackTime
                    })
                    RunLoop.current.run()
                }
                if self.musicPlayer.playbackState != .playing {
                    self.playingMusic = false
                } else {
                    self.playingMusic = true
                }
            }
        }
    }
}

struct SongControls: View {
    @Binding var musicPlayer: MPMusicPlayerController
    @Binding var playingMusic: Bool
    var body: some View {
        HStack(spacing: 55) {
            Button(action: {
                if (self.musicPlayer.currentPlaybackTime <= 3) {
                    self.musicPlayer.skipToPreviousItem()
                } else {
                    self.musicPlayer.skipToBeginning()
                }
            }) {
                Image(systemName: "arrow.left.to.line")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.white)
            }
            Button(action: {
                if (self.musicPlayer.playbackState == .playing) {
                    self.musicPlayer.pause()
                    self.playingMusic = false
                } else {
                    self.musicPlayer.play()
                    self.playingMusic = true
                }
            }) {
                
                Image(systemName: self.playingMusic ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.white)
            }
            Button(action: {
                self.musicPlayer.skipToNextItem()
            }) {
                Image(systemName: "arrow.right.to.line")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.white)
            }
        }
    }
}

struct emptyView: View {
    var body: some View {
        Text("A song you play will appear here!")
    }
}

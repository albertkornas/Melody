//
//  SongPlayerView.swift
//  Melody
//
//  Created by Albert Kornas on 11/12/20.
//

import SwiftUI
import MediaPlayer

struct SongPlayerView: View {
    let song : Song
    @Binding var musicPlayer: MPMusicPlayerController
    @Binding var showPlayerView: Bool
    @State private var playingMusic = true
    @State private var songProgress = 0.0

    var body: some View {
        GeometryReader { window in
            VStack(alignment: .center, spacing: 30) {
                Image(uiImage: (self.musicPlayer.nowPlayingItem?.artwork?.image(at: CGSize(width: window.size.width-30, height: window.size.width-30)) ?? UIImage()))
                    .resizable()
                    .frame(width: window.size.width-30, height: window.size.width-30)
                    .cornerRadius(25)
                VStack(alignment: .leading, spacing: 10) {
                    Text(self.musicPlayer.nowPlayingItem?.title ?? "")
                        .font(.title)
                    Text(self.musicPlayer.nowPlayingItem?.artist ?? "")
                        .font(.subheadline)
                    Text("\(song.trackName ?? "")")
                    
                    let durationInSecs = (song.duration ?? 0)/1000
                    Text("\(durationInSecs)")
                    Slider(value: $musicPlayer.currentPlaybackTime, in:0...durationInSecs, onEditingChanged: { editing in
                        /*if (editing == true) {
                            musicPlayer.pause()
                        } else {
                            if (playingMusic == true) {
                                musicPlayer.play()
                            }
                        }*/
                        print(editing)
                    })
                }
                
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
                .navigationBarTitle(Text("Playing Now"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.showPlayerView = false
                }) {
                    Image(systemName: "chevron.down")
                })
            }
        }.onAppear() {
            if self.musicPlayer.playbackState == .playing {
                self.playingMusic = true
            } else {
                self.playingMusic = false
            }
        }
    }
}

/*struct SongPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SongPlayerView()
    }
}
*/

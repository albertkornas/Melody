//
//  MelodyModel.swift
//  Melody
//
//  Created by Albert Kornas on 11/4/20.
//

import Foundation
import StoreKit
import SwiftJWT
import MediaPlayer


class MelodyModel : ObservableObject {
    
    @Published var playlists : [Playlist] //The list of playlists that the user has
    @Published var musicPlayer = MPMusicPlayerController.applicationMusicPlayer //Utilized to play Media
    @Published var songQueue : [String] //A queue that holds Song ID's
    //@Published var currentSong : Song
    
    let privateKey = """
-----BEGIN PRIVATE KEY-----
MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgZZr8qRLtVuEsDYEM
8iC/u9dc2K5CcirEXCs4MyWhsjCgCgYIKoZIzj0DAQehRANCAAS+YYXf4vjtil0u
s9U6Mgf+eDvGQKseRdRDZt+30nxlrqvDIC0JhEJOa3LKK76nwAptzbNEiDK4OjlD
t+MSB13l
    -----END PRIVATE KEY-----
"""
    
    @Published var musicToken = ""
    
    let devToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiIsImtpZCI6IlRIWFdKNUNNMzcifQ.eyJpc3MiOiI5TUY2TEFGOEZXIiwiZXhwIjoxNjE3NjY3NDMzLjI4NjQzNDIsImlhdCI6MTYwNDYyNDYzMy4yODczNjR9.n6KjBgDv5wmxenAYesKksWgBYY-kgWl9h19QmGRst5dr_lVo3w51OzZXxRAUcf8jOfTNcHOVgvixKkU8QvFqTA"
    
    struct SongData: Codable {
        let id:String
        let type: String
    }

    init() {
        playlists = []
        songQueue = []
    }
    
    func getJWT() {
        let signer = JWTSigner.es256(privateKey: Data(privateKey.utf8))
        let calendar = Calendar.current
        if let exp = calendar.date(byAdding: .month, value: 5, to: Date()) {
             let claims = ClaimsStandardJWT(iss: "9MF6LAF8FW", exp: exp, iat: Date())
             let header = Header(kid: "THXWJ5CM37")
             var myJWT = JWT(header: header, claims: claims)
             do {
                  let signedJWT = try myJWT.sign(using: signer)
                  print(signedJWT)
             } catch {
             }
        }
    }
    
    func getUserToken() {
        var userToken = String()
        SKCloudServiceController().requestUserToken(forDeveloperToken: devToken) { (receivedToken, error) in

            guard error == nil else {
                return
            }
            if let token = receivedToken {
                userToken = token
                print("Token: \(userToken)")
                self.musicToken = userToken
                print("MusicToken: \(self.musicToken)")
                self.fetchUserPlaylists()
            }
        }
        
    }
    
    func fetchUserPlaylists() {
        self.playlists = []
        DispatchQueue.global(qos: .userInitiated).async {
            let musicURL = URL(string: "https://api.music.apple.com/v1/me/library/playlists")!
            var musicRequest = URLRequest(url: musicURL)
            musicRequest.httpMethod = "GET"
            musicRequest.addValue("Bearer \(self.devToken)", forHTTPHeaderField: "Authorization")
            musicRequest.addValue(self.musicToken, forHTTPHeaderField: "Music-User-Token")
            
            DispatchQueue.main.async {
                URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
                    guard error == nil else { return }
                    if let data = data {
                        let decoder = JSONDecoder()
                        do {
                            let retrievedData = try decoder.decode(JSONData.self, from: data)

                            var pl:[Playlist] = []
                            DispatchQueue.main.async {
                                pl = retrievedData.data //All playlists
                                
                                for playlistData in pl {
                                    var newPl = playlistData
                                    self.fetchTracks(playlist: newPl) { output in
                                        newPl.tracks = output
                                        self.playlists.append(newPl)
                                    }
                                }
                            }
                        } catch {
                           // print(error)
                        }
                    }
                    
                }.resume()
            }
        }
    }
    
    func pollPlaybackTime(player: MPMusicPlayerController) -> Double {
        return player.currentPlaybackTime
    }
    
    func fetchTracks(playlist: Playlist, completionBlock: @escaping ([Song]) -> Void) -> Void {
        var songArray : [Song] = []
        DispatchQueue.global(qos: .userInitiated).async {
            let identifier = playlist.id
            let musicURL = URL(string: "https://api.music.apple.com/v1/me/library/playlists/\(identifier)?include=tracks")!
            var musicRequest = URLRequest(url: musicURL)
            musicRequest.httpMethod = "GET"
            musicRequest.addValue("Bearer \(self.devToken)", forHTTPHeaderField: "Authorization")
            musicRequest.addValue(self.musicToken, forHTTPHeaderField: "Music-User-Token")
            
            DispatchQueue.main.async {
                URLSession.shared.dataTask(with: musicRequest, completionHandler: { data, response, error in
                    guard error == nil else { return }
                    if let data = data {
                        do {
                            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                            let arr: [[NSDictionary]] = dictionary.value(forKeyPath: "data.relationships.tracks.data.attributes") as! [[NSDictionary]]
                            for (_, song) in arr[0].enumerated() {
                                var song = Song(albumName: song["albumName"] as? String, artistName: song["artistName"] as? String, artworkURL: song["artwork"] as? NSDictionary, trackName: song["name"] as? String, playParams: song["playParams"] as? NSDictionary, duration: song["durationInMillis"] as? Double)
                                song.duration = song.duration ?? 0 / 1000
                                songArray.append(song)
                                
                            }
                            DispatchQueue.main.async {
                                completionBlock(songArray)
                            }
                        } catch {
                        }
                    }
                }).resume()
            }
        }
        
    }
    
    func searchMusic(input: String!, completionBlock: @escaping ([Song]) -> Void) -> Void {
        var songResults = [Song]()
        
        let url = URL(string: "https://api.music.apple.com/v1/catalog/us/search?term=\(input.replacingOccurrences(of: " ", with: "+"))&types=songs&limit=10")!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(self.devToken)", forHTTPHeaderField: "Authorization")
        request.addValue(self.musicToken, forHTTPHeaderField: "Music-User-Token")
        
        DispatchQueue.main.async {
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else { return }
            if let data = data {
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                    let arr: [NSDictionary] = dictionary.value(forKeyPath: "results.songs.data") as! [NSDictionary]
                    
                    for song in arr {
                        let attributes = song["attributes"] as! NSDictionary
                        let newSong = Song(albumName: attributes["albumName"] as? String, artistName: attributes["artistName"] as? String, artworkURL: attributes["artwork"] as? NSDictionary, trackName: attributes["name"] as? String, playParams: attributes["playParams"] as? NSDictionary, duration: attributes["durationInMillis"] as? Double)
                        songResults.append(newSong)
                    }

                    DispatchQueue.main.async {
                        completionBlock(songResults)
                    }
                } catch {
                    
                }
            }
        }).resume()
        }
    }
    
    func fetchCharts() {
        var playlistResults = [Song]()
        DispatchQueue.global(qos: .userInitiated).async {
            let musicURL = URL(string: "https://api.music.apple.com/v1/catalog/us/charts?types=songs")!
            var musicRequest = URLRequest(url: musicURL)
            musicRequest.httpMethod = "GET"
            musicRequest.addValue("Bearer \(self.devToken)", forHTTPHeaderField: "Authorization")
            musicRequest.addValue(self.musicToken, forHTTPHeaderField: "Music-User-Token")
            
            DispatchQueue.main.async {
                URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
                    guard error == nil else { return }
                    if let data = data {
                        do {
                            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                            print(dictionary)
                        } catch {
                            print(error)
                        }
                    }
                    
                }.resume()
            }
        }
    }
    
    func appendSongToPlaylist(withIndex: Int, withSong: Song) {
        let songIdentifier = withSong.playParams?["id"]
        let songDict = SongData(id: songIdentifier as! String, type: "songs")
        
        var headerStr = Data()
        do {
            headerStr = try JSONEncoder().encode(songDict)
        } catch {
            print("Invalid JSON")
        }

        let url = URL(string: "https://api.music.apple.com/v1/me/library/playlists/\(playlists[withIndex].id)/tracks")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(self.devToken)", forHTTPHeaderField: "Authorization")
        request.addValue(self.musicToken, forHTTPHeaderField: "Music-User-Token")
        request.httpBody = headerStr
        
        DispatchQueue.main.async {
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {return}
            
        }).resume()
        }
        self.playlists[withIndex].tracks?.append(withSong)
    }
    
    func addToQueue(withSongId: String, toBeginning: Bool) {
        if (toBeginning == false) {
            self.songQueue.append(withSongId)
        } else {
            self.songQueue.insert(withSongId, at: 0)
        }
        self.musicPlayer.setQueue(with: songQueue)
    }
    
    func currentlyPlayingSong() -> Song {
        let mediaItem = musicPlayer.nowPlayingItem

        let song = Song(albumName: mediaItem?.albumTitle, artistName: mediaItem?.artist, artworkURL: nil, trackName: mediaItem?.title, playParams: nil, duration: Double(mediaItem?.playbackDuration ?? 0))
        return song
    }
}

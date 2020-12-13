//
//  SongModel.swift
//  Melody
//
//  Created by Albert Kornas on 11/5/20.
//

import Foundation

struct Song : Identifiable, Codable, Hashable {
    var id: String?
    var albumName: String?
    var artistName: String?
    var artworkURL: NSDictionary?
    var trackName: String?
    var playParams: NSDictionary?
    var duration: Double?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case albumName
        case artistName
        case duration = "durationInMillis"
    }
    
    init(albumName: String?, artistName: String?, artworkURL: NSDictionary?, trackName: String?, playParams: NSDictionary?, duration: Double?) {
        self.id = ""
        self.albumName = albumName
        self.artistName = artistName
        self.artworkURL = artworkURL
        self.trackName = trackName
        self.playParams = playParams
        self.duration = (duration ?? 0/1000)
    }
}

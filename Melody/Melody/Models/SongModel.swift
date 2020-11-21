//
//  SongModel.swift
//  Melody
//
//  Created by Albert Kornas on 11/5/20.
//

import Foundation

struct Song : Identifiable, Codable, Hashable {
    var id: String
    var albumName: String?
    var artistName: String?
    var artworkURL: NSDictionary?
    var trackName: String?
    //var duration: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case albumName
        case artistName
        //case artworkURL = "url"
        //case duration = "durationInMillis"
    }
    
    init(albumName: String?, artistName: String?, artworkURL: NSDictionary?, trackName: String?) {
        self.id = "F"
        self.albumName = albumName
        self.artistName = artistName
        self.artworkURL = artworkURL
        self.trackName = trackName
    }
}

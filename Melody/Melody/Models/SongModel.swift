//
//  SongModel.swift
//  Melody
//
//  Created by Albert Kornas on 11/5/20.
//

import Foundation

struct Song {
    var id: String
    var title: String
    var image: String
    var artist: String
    var name: String
    
    init(id: String, title: String, image: String, artist: String, name: String) {
        self.id = id
        self.title = title
        self.image = image
        self.artist = artist
        self.name = name
    }
    
}

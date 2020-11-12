//
//  Playlist.swift
//  Melody
//
//  Created by Albert Kornas on 11/12/20.
//

import Foundation

struct Playlist : Codable, Identifiable {
    
    var id: String
    var attributes: Attributes
    
    enum CodingKeys: String, CodingKey {
        case id
        case attributes
    }
}

struct JSONData : Codable {
    var data: [Playlist]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct Attributes: Codable {
    var name: String
    var dateAdded: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case dateAdded
    }
}

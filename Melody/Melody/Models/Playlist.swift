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
    var tracks: [Song]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case attributes
    }
    
    init(withTracks: [Song]?, withChartName: String) {
        self.tracks = withTracks
        self.id = "chart"
        let attr = Attributes(name: withChartName)
        self.attributes = attr
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
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

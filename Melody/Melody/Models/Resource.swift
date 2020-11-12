//
//  Resource.swift
//  Melody
//
//  Created by Albert Kornas on 11/12/20.
//

/* It turns out that making API calls to retrieve songs, playlists, and maybe other relevant
 information that I haven't tried to get yet, returns an array of Resource objects. Each
 resource objects JSON is formatted similarly, so I figure we can group songs & playlists
 together so we don't have to create redundant models */

import Foundation

struct Resource {
    struct TopLayer: Codable {
        let data: [Data]
    }
    
    enum CodingKeys : CodingKey{
        case data
    }
    
}

//
//  ClassicsModel.swift
//  
//
//  Created by Albert Kornas on 10/19/20.
//

import Foundation

struct Book: Hashable {
    let author: String
    let country: String
    let image: String
    let language: String
    let link: String
    let pages: Int
    let title: String
    let year: Int
    
    private enum CodingKeys: String, CodingKey {
        case author
        case country
        case image
        case language
        case link
        case pages
        case title
        case year
    }
}

extension Book: Codable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        //Use decode on properties that are always present
        author = try values.decode(String.self, forKey: .author)
        country = try values.decode(String.self, forKey: .country)
        image = try values.decode(String.self, forKey: .image)
        language = try values.decode(String.self, forKey: .language)
        link = try values.decode(String.self, forKey: .link)
        pages = try values.decode(Int.self, forKey: .pages)
        title = try values.decode(String.self, forKey: .title)
        year = try values.decode(Int.self, forKey: .year)
        
        //Use decodeIfPresent because these properties may not be present
        
        /*These properties will most likely be
        1. Current Page Num
        2. Notes
         */
        
        //Don't forget to assign default value
    }
}

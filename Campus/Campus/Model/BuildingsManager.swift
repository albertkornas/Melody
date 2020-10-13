//
//  BuildingsManager.swift
//  Campus
//
//  Created by Albert Kornas on 10/13/20.
//

import Foundation
import MapKit

struct Place: Codable, Identifiable, Equatable {
    var isFavorited: Bool
    var id = UUID()
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var name: String
    var opp_bldg_code: Double
    var year_constructed: Int?
    var coordinate: CLLocationCoordinate2D {CLLocationCoordinate2DMake(latitude, longitude)}
    
    enum CodingKeys: String, CodingKey {
        case isFavorited = "is_favorited"
        case latitude
        case longitude
        case name
        case opp_bldg_code
        case year_constructed
    }
}

typealias AllPlaces = [Place]
class BuildingsManager {
    let destinationURL : URL
    
    var allPlaces: AllPlaces
    
    init() {
        allPlaces = []
        
        let mainBundle = Bundle.main
        let filename = "buildings"
        let bundleURL = mainBundle.url(forResource: filename, withExtension: "json")!
        
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        destinationURL = documentURL.appendingPathComponent(filename + ".json")
        let fileExists = fileManager.fileExists(atPath: destinationURL.path)
        
        do {
            let url = fileExists ? destinationURL : bundleURL
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            self.allPlaces = try decoder.decode(AllPlaces.self, from: data)
        } catch {
            self.allPlaces = []
        }
        
        self.allPlaces.sort{$0.name < $1.name}
    }
    
    
    
}

//
//  CampusData.swift
//  Campus
//
//  Created by Albert Kornas on 10/4/20.
//

import Foundation
import CoreLocation

struct Spot : Identifiable {
    let coordinate : CLLocationCoordinate2D
    let title : String?
    var id = UUID()
    
    init(coordinate:CLLocationCoordinate2D, title:String? = nil) {
        self.coordinate = coordinate
        self.title = title
    }
}

struct CampusData {
    //MARK: - Locations
    // Centered on Penn State's campus
    static let initialCoordinate = CLLocationCoordinate2D(latitude: 40.799574, longitude: -77.861780)
    static let span : CLLocationDegrees = 0.013
    static let zoomSpan : CLLocationDegrees = 0.0075
    
    static let downtownCoordinates = [(40.791831951313,-77.865203974557),
                                      (40.800364570711,-77.853778542571),
                                      (40.799476294037,-77.8525124806654),
                                      (40.7908968034537,-77.8638607142546)].map {(a,b) in CLLocationCoordinate2D(latitude: a, longitude: b)}
    
}

//
//  LocationsManager.swift
//  Campus
//
//  Created by Albert Kornas on 10/4/20.
//

import Foundation
import MapKit

struct Place : Identifiable {
    var id = UUID()
    var placemark : MKPlacemark
    
    var name : String {placemark.name ?? "No Name"}
    var buildingCode: String {placemark.subAdministrativeArea ?? ""}
    var coordinate : CLLocationCoordinate2D {placemark.location!.coordinate}
}

struct Place2: Codable {
    /*
     "latitude": 40.8017390346291,
     "longitude": -77.8543146925926,
     "name": "Curry Hall",
     "opp_bldg_code": 270002,
     "year_constructed": 2004
     */
    var latitude: Double
    var longitude: Double
    var name: String
    var opp_bldg_code: Int
    var year_constructed: Int
}

typealias AllPlaces = [Place2]
class LocationsManager: ObservableObject {
    //MARK: Published values
    @Published var region = MKCoordinateRegion(center: TownData.initialCoordinate, span: MKCoordinateSpan(latitudeDelta: TownData.span, longitudeDelta: TownData.span))
    
    // Map will annotate these items
    @Published var mappedPlaces = [Place]()
    let destinationURL : URL
    
    var allPlaces: [Place2]
    init() {
        let filename = "buildings"
        let mainBundle = Bundle.main
        let bundleURL = mainBundle.url(forResource: filename, withExtension: "json")!
        
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        destinationURL = documentURL.appendingPathComponent(filename + ".json")
        let fileExists = fileManager.fileExists(atPath: destinationURL.path)
        
        do {
            let url = fileExists ? destinationURL : bundleURL
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            allPlaces = try decoder.decode(AllPlaces.self, from: data)
        } catch {
            allPlaces = []
            print("here")
        }
        print(allPlaces)
    }
}

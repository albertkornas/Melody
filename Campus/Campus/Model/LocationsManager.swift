//
//  LocationsManager.swift
//  Campus
//
//  Created by Albert Kornas on 10/4/20.
//

import Foundation
import MapKit

/*struct Place : Identifiable {
    var id = UUID()
    var placemark : MKPlacemark
    
    var name : String {placemark.name ?? "No Name"}
    var buildingCode: String {placemark.subAdministrativeArea ?? ""}
    var coordinate : CLLocationCoordinate2D {placemark.location!.coordinate}
}*/

struct Place: Codable, Identifiable {
    var id = UUID()
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var name: String
    var opp_bldg_code: Double
    var year_constructed: Int?
    var coordinate: CLLocationCoordinate2D?
    var isFavorited: Bool
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case name
        case opp_bldg_code
        case year_constructed
        case isFavorited = "is_favorited"
    }
}

typealias AllPlaces = [Place]
class LocationsManager: ObservableObject {
    //MARK: Published values
    @Published var region = MKCoordinateRegion(center: TownData.initialCoordinate, span: MKCoordinateSpan(latitudeDelta: TownData.span, longitudeDelta: TownData.span))
    
    // Map will annotate these items
    @Published var mappedPlaces = [Place]()
    
    @Published var allPlaces: AllPlaces {
        didSet {
            saveData()
        }
    }
    
    let mainURL: URL
    
    init() {
        allPlaces = []
        mainURL = Bundle.main.url(forResource: "buildings", withExtension: "json")!
        
        do {
            let data = try Data(contentsOf: mainURL)
            let decoder = JSONDecoder()
            self.allPlaces = try decoder.decode(AllPlaces.self, from: data)
            
        } catch {
            self.allPlaces = []
        }
        
        self.allPlaces.sort{$0.name < $1.name}
        
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(allPlaces)
            try data.write(to: self.mainURL)
            print(allPlaces)
        } catch  {
            print("Error writing: \(error)")
        }
    }
}

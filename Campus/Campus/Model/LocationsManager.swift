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
class LocationsManager: ObservableObject {
    //MARK: Published values
    @Published var region = MKCoordinateRegion(center: TownData.initialCoordinate, span: MKCoordinateSpan(latitudeDelta: TownData.span, longitudeDelta: TownData.span))
    
    // Map will annotate these items
    @Published var mappedPlaces = [Place]()
    
    var favoritedPlaces = [Place]()
    var plottedPlaces = [Place]()
    
    @Published var allPlaces: AllPlaces {
        didSet {
            saveData()
        }
    }
    
    var showingFavorites: Bool = true
    
    let destinationURL : URL
    
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
    
    func clearAnnotations() {
        mappedPlaces.removeAll()
    }
    
    func toggleFavoritedAnnotations() {
        if (showingFavorites == false) {
            clearAnnotations()
            for favPlace in favoritedPlaces {
                mappedPlaces.append(favPlace)
            }
            showingFavorites = true
        } else {
            clearAnnotations()
            for plottedPlace in plottedPlaces {
                mappedPlaces.append(plottedPlace)
            }
            showingFavorites = false
        }
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(allPlaces.self)
            try data.write(to: self.destinationURL)
        } catch  {
            print("Error writing: \(error)")
        }
        mappedPlaces.removeAll()
        favoritedPlaces.removeAll()
        for place in allPlaces {
            if place.isFavorited == true {
                if (showingFavorites == true) {
                    mappedPlaces.append(place)
                }
                favoritedPlaces.append(place)
            }
        }
    }
    
    func updateMappedPlaces(index:Int) {
        
    }
}

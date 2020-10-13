//
//  LocationsManager.swift
//  Campus
//
//  Created by Albert Kornas on 10/4/20.
//

import Foundation
import MapKit



class LocationsManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let locationManager : CLLocationManager
    var showsUserLocation = true
    
    //MARK: Published values
    @Published var region = MKCoordinateRegion(center: CampusData.initialCoordinate, span: MKCoordinateSpan(latitudeDelta: CampusData.span, longitudeDelta: CampusData.span))
    
    // Map will annotate these items
    @Published var mappedPlaces = [Place]()
    
    var favoritedPlaces = [Place]()
    var plottedPlaces = [Place]()
    
    @Published var allPlaces: AllPlaces {
        didSet {
            saveData()
        }
    }
    
    //MARK: - CLLocationManager Delegate
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            showsUserLocation = true
        default:
            locationManager.stopUpdatingLocation()
            showsUserLocation = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newCoordinates = locations.map {$0.coordinate}
        if let coordinate = newCoordinates.first {
            region.center = coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         
    }
    
    var showingFavorites: Bool = true

    
    override init() {
        let buildingsManager = BuildingsManager()
        allPlaces = buildingsManager.allPlaces
        
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    func clearAnnotations() {
        plottedPlaces.removeAll()
        mappedPlaces = favoritedPlaces
    }
    
    func saveData() {
        /*let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(allPlaces.self)
            try data.write(to: self.destinationURL)
        } catch  {
            print("Error writing: \(error)")
        }
        mappedPlaces.removeAll()
        for place in plottedPlaces {
            mappedPlaces.append(place)
        }
        favoritedPlaces.removeAll()
        for place in allPlaces {
            if place.isFavorited == true {
                if (showingFavorites == true) {
                    mappedPlaces.append(place)
                }
                favoritedPlaces.append(place)
            }
        }*/
        print("Save template")
    }
    
    func centerLocation() {
        region.center = locationManager.location!.coordinate
    }
    
    
    func toggleFavoritedAnnotations() {
        if (showingFavorites == false) {
            mappedPlaces.removeAll()
            for favPlace in favoritedPlaces {
                mappedPlaces.append(favPlace)
            }
            for plottedPlace in plottedPlaces {
                mappedPlaces.append(plottedPlace)
            }
            showingFavorites = true
        } else {
            mappedPlaces.removeAll()
            for plottedPlace in plottedPlaces {
                mappedPlaces.append(plottedPlace)
            }
            showingFavorites = false
        }
    }
    
    
    func plotOnMap(building: Place) {
        if (!plottedPlaces.contains(building)) {
            if (favoritedPlaces.contains(building)) {
                //overlap
                let indexOfFav = favoritedPlaces.firstIndex(of: building)!
                favoritedPlaces.remove(at: indexOfFav)
            }
            plottedPlaces.append(building)
            if (!mappedPlaces.contains(building)) {
                mappedPlaces.append(building)
            }
        }
        region = MKCoordinateRegion(center: building.coordinate, span: MKCoordinateSpan(latitudeDelta: CampusData.zoomSpan, longitudeDelta: CampusData.zoomSpan))
    }
}

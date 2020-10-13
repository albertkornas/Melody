//
//  CampusMapView.swift
//  Campus
//
//  Created by Albert Kornas on 10/4/20.
//

import SwiftUI
import MapKit

struct CampusMapView: View {
    @EnvironmentObject var locationsManager: LocationsManager
    @State var userTrackingMode  : MapUserTrackingMode = .follow
    var showFav = true
    var body: some View {
        Map(coordinateRegion: $locationsManager.region,
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode,
            annotationItems: locationsManager.mappedPlaces,
            annotationContent: annotationPins)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    clearButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    favoritesButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    centerButton
                }
            }
    }
    
    
    //MARK: Three different functions for creating annotations
    func annotationsForCategory (item:Place) -> some MapAnnotationProtocol {
        MapAnnotation(coordinate: item.coordinate) {
            
        }
    }
    
    func annotationPins (item:Place) -> some MapAnnotationProtocol {
        MapPin(coordinate: item.coordinate, tint: item.isFavorited ? Color.blue : Color.red)
            
    }
    
    func annotationMarkers (item:Place) -> some MapAnnotationProtocol {
        MapMarker(coordinate: item.coordinate)
    }
    
    var clearButton : some View {Button(action: {locationsManager.clearAnnotations()}) {
        Image(systemName: "xmark.circle")}
    }
    
    var favoritesButton : some View {Button(action: {locationsManager.toggleFavoritedAnnotations()}) {
        Text("Toggle Favorites")}
    }
    
    var centerButton : some View {Button(action: {locationsManager.centerLocation()}) {
        Text("Center Map")}
    }
    
}

struct CampusMapView_Previews: PreviewProvider {
    static var previews: some View {
        CampusMapView()
    }
}

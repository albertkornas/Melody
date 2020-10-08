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
                ToolbarItem(placement: .navigationBarTrailing) {
                    clearButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    favoritesButton
                }
            }
    }
    
    
    //MARK: Three different functions for creating annotations
    func annotationsForCategory (item:Place) -> some MapAnnotationProtocol {
        MapAnnotation(coordinate: item.coordinate) {
            Text("HI")
        }
    }
    func annotationPins (item:Place) -> some MapAnnotationProtocol {
        MapPin(coordinate: item.coordinate)
    }
    func annotationMarkers (item:Place) -> some MapAnnotationProtocol {
        MapMarker(coordinate: item.coordinate)
    }
    
    var clearButton : some View {Button(action: {locationsManager.clearAnnotations()}) {
        Image(systemName: "xmark.circle")}
    }
    
    var favoritesButton : some View {Button(action: {locationsManager.toggleFavoritedAnnotations()}) {
        Image(systemName: "star.fill")}
    }
    
}

struct CampusMapView_Previews: PreviewProvider {
    static var previews: some View {
        CampusMapView()
    }
}

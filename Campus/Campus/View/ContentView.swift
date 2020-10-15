//
//  ContentView.swift
//  Campus
//
//  Created by Albert Kornas on 10/4/20.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @ObservedObject var locationsManager = LocationsManager()
    var body: some View {
        NavigationView {
        ZStack {
            VStack {
                CampusMapView().navigationBarTitleDisplayMode(.inline)
                BuildingsListView().frame(height: 90.0)
            }
            if locationsManager.route != nil {
                VStack {
                    DirectionsView(route: $locationsManager.route)
                        .frame(height:60.0)
                    Spacer()
                }
            }
        }
        }.environmentObject(locationsManager)
    }
}


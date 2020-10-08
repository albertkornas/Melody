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
        VStack {
                CampusMapView().navigationBarTitleDisplayMode(.inline)
                BuildingsListView().frame(height: 60.0)
            }
        }.environmentObject(locationsManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

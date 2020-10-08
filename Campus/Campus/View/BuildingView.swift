//
//  BuildingView.swift
//  Campus
//
//  Created by Albert Kornas on 10/5/20.
//

import SwiftUI

struct BuildingView: View {
    @EnvironmentObject var locationsManager : LocationsManager
    @Binding var building: Place
   
    var body: some View {
        HStack {
            VStack {
                Text(building.name)
                Button(action: {
                    locationsManager.plotOnMap(building: building)
                }) {
                    Text("Plot on Map")
                }
            }
            FavButton(isFavorited: $building.isFavorited)
        }
    }
}

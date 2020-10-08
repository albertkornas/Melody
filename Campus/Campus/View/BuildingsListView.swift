//
//  BuildingsListView.swift
//  Campus
//
//  Created by Albert Kornas on 10/5/20.
//

import SwiftUI

struct BuildingsListView: View {
    @EnvironmentObject var locationsManager : LocationsManager
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(locationsManager.allPlaces.indices, id:\.self) { index in
                    BuildingView(building: self.$locationsManager.allPlaces[index])
                        .padding()
                }
            }
        }
    }
}

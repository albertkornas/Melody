//
//  BuildingView.swift
//  Campus
//
//  Created by Albert Kornas on 10/5/20.
//

import SwiftUI

struct BuildingView: View {
    
    @Binding var building: Place
   
    var body: some View {
        HStack {
            Text(building.name)
            FavButton(isFavorited: $building.isFavorited)
        }
    }
}

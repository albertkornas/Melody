//
//  DirectionsView.swift
//  Campus
//
//  Created by Albert Kornas on 10/15/20.
//

import SwiftUI
import MapKit

struct DirectionsView: View {
    @Binding var route : MKRoute?
    @EnvironmentObject var locationsManager: LocationsManager
    
    var body: some View {
        TabView {
            ForEach(route?.steps ?? [], id:\.instructions) {step in
                Text(step.instructions)
            }
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.blue)
        .onDisappear() {
            route = nil
        }
    }
}

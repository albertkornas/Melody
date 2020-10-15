//
//  NavigationStepsView.swift
//  Campus
//
//  Created by Albert Kornas on 10/15/20.
//

import SwiftUI
import MapKit

struct NavigationStepsView: View {
    @Binding var route : MKRoute?
    
    var body: some View {
        ScrollView(.vertical) {
            Text("Expanded Directions")
                .font(.title)
            if (route?.steps != nil) {
                ForEach(route?.steps ?? [], id:\.instructions) {step in
                    VStack(alignment: .center) {
                        Text(step.instructions)
                            .font(.body)
                    }
                }
            } else {
                Text("No route selected")
            }
        }
    }
}


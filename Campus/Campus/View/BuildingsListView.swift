//
//  BuildingsListView.swift
//  Campus
//
//  Created by Albert Kornas on 10/5/20.
//

import SwiftUI

struct BuildingsListView: View {
    @EnvironmentObject var locationsManager : LocationsManager
    @State private var isShowingSteps = false
    
    var body: some View {
        TabView {
            
                ForEach(locationsManager.allPlaces.indices, id:\.self) { index in
                    ZStack {
                    Button(action: { self.isShowingSteps.toggle() }) {
                        
                    }.sheet(isPresented: $isShowingSteps) {
                        NavigationStepsView(route: $locationsManager.route)
                            
                    }
                        BuildingView(building: self.$locationsManager.allPlaces[index])
                            .padding()
                    }
                }
                
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

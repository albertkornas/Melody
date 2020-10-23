//
//  ContentView.swift
//  Classics
//
//  Created by Albert Kornas on 10/19/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var classicModel : ClassicModel
    var body: some View {
        NavigationView {
            ClassicsListView()
        }.environmentObject(classicModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  Pokedex
//
//  Created by Albert Kornas on 9/22/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = PokemonModel()
    @State var sectionStyle : SectionStyle = .none
    var body: some View {
        PokemonListView(sectionStyle: $sectionStyle)
            .environmentObject(model)
    }
}

/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/

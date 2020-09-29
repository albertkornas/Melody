//
//  ContentView.swift
//  Pokedex
//
//  Created by Albert Kornas on 9/22/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let model = PokemonModel()
    @State var pokeModel = PokemonModel()
    @State var sectionStyle : SectionStyle = .none
    var body: some View {
        PokemonListView(pokemodel: $pokeModel, sectionStyle: $sectionStyle)
    }
}

/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/

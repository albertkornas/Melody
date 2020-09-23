//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Albert Kornas on 9/23/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import SwiftUI

enum SectionStyle: String, CaseIterable {
    case none, byName, byDecade
}

struct PokemonListView: View {
    @Binding var pokemodel : PokemonModel
    @Binding var sectionStyle : SectionStyle
    
    var body: some View {
        NavigationView {
            List {
                ForEach(pokemodel.allPokemon.indices, id:\.self) {index in
                    NavigationLink(destination: DetailView(pokemon: self.$pokemodel.allPokemon[index])) {
                        PokeRowView(pokemon: self.pokemodel.allPokemon[index])
                    }
                }
            }.navigationBarTitle("Pokedex", displayMode: .inline)
        }
        
    }
}

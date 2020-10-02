//
//  SectionViews.swift
//  Pokedex
//
//  Created by Albert Kornas on 9/29/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import SwiftUI

struct SectionViews: View {
    @EnvironmentObject var model : PokemonModel
    var filter : ((Pokemon) -> Bool)
    
    var body : some View {
        ForEach(model.pokemonIndices(for: filter), id:\.self) { index in
            NavigationLink(destination: DetailView(pokemon: self.$model.allPokemon[index])) {
                PokeRowView(pokemon: self.model.allPokemon[index])
            }
        }
    }
}

//
//  CategoryRow.swift
//  Pokedex
//
//  Created by Albert Kornas on 9/29/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import SwiftUI

struct CategoryRow: View {
    @EnvironmentObject var model : PokemonModel
    let categoryName: String
    
    let property : ((Pokemon) -> Bool)
    
    var nonEmpty : Bool {model.pokemonIndices(for: property).count > 0 }
    
    var body: some View {
        VStack(alignment: .leading) {
            if nonEmpty {
                Text(categoryName)
                    .font(.headline)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(model.pokemonIndices(for: property), id:\.self) {index in
                            NavigationLink(destination: DetailView(pokemon:self.$model.allPokemon[index])) {
                                CategoryItem(thePokemon: self.$model.allPokemon[index])
                            }
                        }
                    }
                }.frame(height: 185)
            } else {
                EmptyView()
            }
        }
    }
}

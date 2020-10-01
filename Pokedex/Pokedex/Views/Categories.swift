//
//  Categories.swift
//  Pokedex
//
//  Created by Albert Kornas on 9/30/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import SwiftUI

struct Categories: View {
    @EnvironmentObject var pokemodel : PokemonModel
    
    var body: some View {
        Group {
            ForEach(pokemodel.types, id:\.self) { type in
                CategoryRow(model: _pokemodel, categoryName: "hi", property: {$0.id == 5})
            }
            
        }
    }
}

struct Categories_Previews: PreviewProvider {
    static var previews: some View {
        Categories()
    }
}

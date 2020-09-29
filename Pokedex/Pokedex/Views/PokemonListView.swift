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
    @State private var pokeType: PokemonType?

    var body: some View {
        NavigationView {
            List {
                ForEach(pokemodel.allPokemon.indices, id:\.self) {index in
                    NavigationLink(destination: DetailView(pokemon: self.$pokemodel.allPokemon[index])) {
                        PokeRowView(pokemon: self.pokemodel.allPokemon[index])
                    }
                    
                }
                

            }.navigationBarTitle("Pokedex", displayMode: .inline)
                .navigationBarItems(trailing: Picker(selection: $pokeType, label: Text("Fruit")) {
                     ForEach(PokemonType.allCases) { fruit in
                         Text(fruit.rawValue).tag(fruit as PokemonType?)
                     }
                }.pickerStyle(DefaultPickerStyle()))
        }
        
    }
    
    var menuPicker: some View {
        Picker(selection: $pokeType, label: Text("Fruit")) {
             ForEach(PokemonType.allCases) { fruit in
                 Text(fruit.rawValue).tag(fruit as PokemonType?)
             }
         }
    }
}

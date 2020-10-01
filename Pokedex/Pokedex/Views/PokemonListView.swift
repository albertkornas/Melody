//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Albert Kornas on 9/23/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import SwiftUI


struct PokemonListView: View {
    @EnvironmentObject var pokemodel : PokemonModel
    @State private var pokeType: PokemonType?

    var body: some View {
        NavigationView {
            List {
                if pokeType != nil {
                    Section(header: Text(pokeType!.rawValue)) {
                        SectionViews(model: self._pokemodel,
                                     filter: self.sectionFilter(for: pokeType!.rawValue))
                    }
                } else {
                    ForEach(sectionTitles(), id: \.self) { sectionTitle in
                        Section(header: Text(sectionTitle)) {
                            SectionViews(model: self._pokemodel,
                                         filter: self.sectionFilter(for: sectionTitle))
                        }
                    }
                }
            }.navigationBarTitle("Pokedex", displayMode: .inline)
            .navigationBarItems(trailing: Picker(selection: $pokeType, label: Text("Pokedex")) {
                     ForEach(PokemonType.allCases) { pokemon in
                         Text(pokemon.rawValue).tag(pokemon as PokemonType?)
                     }
                }.pickerStyle(MenuPickerStyle()))
        }
    }
    
    // generate array of section titles based on section style
    func sectionTitles() -> [String] {
        return PokemonType.allCases.map{$0.rawValue}
    }
    
    // generate a filter (predicate function) that tests whether a Pokemon belongs in the section with title sectionTitle
    func sectionFilter(for sectionTitle:String) -> ((Pokemon) -> Bool) {
        return {$0.types.contains(PokemonType(rawValue: sectionTitle)!)}
    }
}

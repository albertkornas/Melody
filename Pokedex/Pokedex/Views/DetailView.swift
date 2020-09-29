//
//  DetailView.swift
//  Pokedex
//
//  Created by Albert Kornas on 9/23/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @Binding var pokemon: Pokemon

    var body: some View {
            VStack(spacing:20) {
                
                CapturedButton(isCaptured: $pokemon.captured)
                        Image(String(format: "%03d", pokemon.id))
                        .resizable()
                        .padding()
                        .scaledToFit()
                            .frame(height:self.imageHeight)
                        .clipped()
                        .listRowInsets(EdgeInsets())
                VStack(alignment: .center, spacing: 50) {
                HStack {
                        Text(String(format: "Height: %.2fm",  pokemon.height))
                            Text(String(format: "Weight: %.1fkg", pokemon.weight))
                    }
                HStack(alignment: .top, spacing: 100) {
                        
                        VStack {
                            Text("Types:")
                            ForEach(pokemon.types, id: \.self) {type in
                                Text(type.rawValue)
                                    .foregroundColor(Color.init(pokemonType: type))
                            }
                        }
                        
                        VStack {
                            Text("Weaknesses:")
                            ForEach(pokemon.weaknesses, id: \.self) {weakness in
                                Text(weakness.rawValue)
                                    .foregroundColor(Color.init(pokemonType:weakness))
                            }
                        }
                    }
                }
            }.navigationBarTitle(pokemon.name)
    }
    let imageHeight : CGFloat = 250
}

struct DetailView_Previews: PreviewProvider {
    @State static var pokemon = PokemonModel()
    static var previews: some View {
        DetailView(pokemon: $pokemon.allPokemon[0])
    }
}

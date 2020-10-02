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
    @EnvironmentObject var model : PokemonModel

    var body: some View {
        
            VStack(spacing:20) {
                List {
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

                        if (pokemon.nextEvolution != nil) {
                        Text("Evolves into:")
                            
                            ForEach(pokemon.nextEvolution!.indices, id: \.self) {evol in
                                VStack {
                                NavigationLink(destination: DetailView(pokemon: self.$model.allPokemon[pokemon.nextEvolution![evol]-1])) {
                                    
                            Image(String(format: "%03d", pokemon.nextEvolution![evol]))
                                .resizable()
                                .scaledToFit()
                                .frame(height:self.imageHeight/2)
                                }
                            }
                        }
                    }
                    
                    if (pokemon.prevEvolution != nil) {
                    Text("Evolves from:")
                        
                        ForEach(pokemon.prevEvolution!.indices, id: \.self) {evol in
                            VStack {
                            NavigationLink(destination: DetailView(pokemon: self.$model.allPokemon[pokemon.prevEvolution![evol]-1])) {
                                
                        Image(String(format: "%03d", pokemon.prevEvolution![evol]))
                            .resizable()
                            .scaledToFit()
                            .frame(height:self.imageHeight/2)
                            }
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

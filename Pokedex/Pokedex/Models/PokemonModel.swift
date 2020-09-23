//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Albert Kornas on 9/22/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    
    let id : Int
    let name: String
    let types : [PokemonType]
    let height: Double
    let weight: Double
    let weaknesses: [PokemonType]
    let nextEvolution: [Int]?
    let prevEvolution: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case types
        case height
        case weight
        case weaknesses
        case nextEvolution = "next_evolution"
        case prevEvolution = "prev_evolution"
    }
}

typealias AllPokemon = [Pokemon]

struct PokemonModel {
    var allPokemon : AllPokemon
    
    init() {
        let filename = "pokedex"
        let mainBundle = Bundle.main
        let jsonURL = mainBundle.url(forResource: filename, withExtension: "json")!
        
        do {
            let data = try Data(contentsOf: jsonURL)
            let decoder = JSONDecoder()
            allPokemon = try decoder.decode(AllPokemon.self, from: data)
        } catch {
            allPokemon = []
        }
    }
}


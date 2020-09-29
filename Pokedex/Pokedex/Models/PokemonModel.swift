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
    var captured: Bool
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case types
        case height
        case weight
        case weaknesses
        case nextEvolution = "next_evolution"
        case prevEvolution = "prev_evolution"
        case captured
    }
}

typealias AllPokemon = [Pokemon]

class PokemonModel : ObservableObject {
    var allPokemon : AllPokemon {
        didSet {
            saveData()
        }
    }
    var selectedFilter: PokemonType?
    let destinationURL : URL
    
    init() {
        let filename = "pokedex-v2"
        let mainBundle = Bundle.main
        let bundleURL = mainBundle.url(forResource: filename, withExtension: "json")!
        
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        destinationURL = documentURL.appendingPathComponent(filename + ".json")
        let fileExists = fileManager.fileExists(atPath: destinationURL.path)
        
        do {
            let url = fileExists ? destinationURL : bundleURL
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            allPokemon = try decoder.decode(AllPokemon.self, from: data)
        } catch {
            allPokemon = []
        }
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        do {
            let data  = try encoder.encode(allPokemon)
            try data.write(to: self.destinationURL)
        } catch  {
            print("Error writing: \(error)")
        }
    }
    
}


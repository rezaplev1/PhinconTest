//
//  PokemonList.swift
//  PhinconTest
//
//  Created by reza pahlevi on 13/09/23.
//

import Foundation

// MARK: - PokemonList
struct PokemonList: Codable {
    let next: String?
    let results: [Pokemon]?
    let previous: String?
    let count: Int?
}

// MARK: - Pokemon
struct Pokemon: Codable {
    let name: String?
    let url: String?
    var imgUrl: String? {
        if let id = URL(string: url ?? "")?.lastPathComponent {
            return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(String(describing:id)).png"
        }else {
            return nil
        }
    }
    
}

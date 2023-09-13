//
//  PokemonDetail.swift
//  PhinconTest
//
//  Created by reza pahlevi on 13/09/23.
//

import Foundation

// MARK: - PokemonDetail
struct PokemonDetail: Codable {
   
    let height: Int?
    let id: Int?
    let moves: [Move]?
    let name: String?
    let types: [TypeElement]?
    let weight: Int?
    
    var movesDetail: String {
        if let data = moves {
            let movesString = data.map { String($0.move?.name ?? "") }.joined(separator: ", ")
            return "Moves: \(movesString)"
            
        }
        return ""
    }
    
    var typesDetail: String {
        if let data = types {
            let movesString = data.map { String($0.type?.name ?? "") }.joined(separator: ", ")
            return "Types: \(movesString)"
            
        }
        return ""
    }
    
    var moveAndTypeDetail: String {
        return "\(movesDetail)\n\n\(typesDetail)"
    }
    
    
}


// MARK: - Move
struct Move: Codable {
    let move: Species?
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int?
    let type: Species?
}

// MARK: - Species
struct Species: Codable {
    let name: String?
    let url: String?
}

//
//  PokemonResult.swift
//  StridesiOSInterview
//
//  Created by Austin Betzer on 4/27/21.
//

import Foundation


struct PokemonResult: Decodable {
    let count: Int
    let next: URL
    
    let pokemon: [Pokemon]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case pokemon = "results"
    }
    
    struct Pokemon: Codable {
        let name: String
        let pokemanDetailsURL: URL
    
        enum CodingKeys: String, CodingKey {
            case name
            case pokemanDetailsURL = "url"
        }
    }
}

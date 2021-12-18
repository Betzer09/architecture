//
//  PokemanDetails.swift
//  StridesiOSInterview
//
//  Created by Austin Betzer on 4/27/21.
//

import Foundation

struct PokemanDetailsModel: Decodable {
    let baseExperience: Int
    let id: Int
    let sprites: Sprites
    let weight: Int
    let name: String
    let order: Int
    private let moves: [MoveResult]
    
    lazy var orderedMoves: [MoveResult] = {
        return moves.sorted(by: { $0.versionGroupDetails.first?.levelLearnedAt ?? 0 < $1.versionGroupDetails.first?.levelLearnedAt ?? 0})
    }()
    
    
    struct Sprites: Decodable {
        let frontDefault: URL
    }
    
    struct MoveResult: Decodable {
        let move: Move
        let versionGroupDetails: [Version]
        
        struct Move: Decodable {
            let name: String
        }
        
        struct Version: Decodable {
            let levelLearnedAt: Int
        }
    }
    
//    enum CodingKeys: String, CodingKey {
//        case baseExperience = "base_experience"
//        case id
//        case sprites
//        case weight
//        case moveResult = "moves"
//    }
    
}

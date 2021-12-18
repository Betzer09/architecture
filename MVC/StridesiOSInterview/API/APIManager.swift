//
//  APIManager.swift
//  StridesiOSInterview
//
//  Created by Austin Betzer on 4/27/21.
//

import Foundation


enum APIEndpoint: String {
    case allPokeman = "pokemon"
}

class APIManager {
    
    class func loadAllPokeman(completion: @escaping (Result<[PokemanDetails], Error>) -> ()) {
        loadPokemanList { (result) in
            switch result {
            case .failure(let e):
                print("[APIManager] failed to load pokeman list: \(e.localizedDescription)")
                completion(.failure(e))
            case .success(let value):
                loadPokeman(value, completion: completion)
            }
        }
    }
    
    class private func loadPokemanDetail(from url: URL, completion: @escaping(Result<PokemanDetails, Error>) -> ()) {
        BackendManager.httpRequest(method: .get, endpoint: url.absoluteString, includeBase: false, completion: completion)
    }
    
    /// Loads the a list of available pokeman
    class private func loadPokemanList(limit: Int = 20, completion: @escaping (Result<PokemonResult, Error>) -> ()) {
        let path = APIEndpoint.allPokeman.rawValue + "?limit=\(limit)"
        BackendManager.httpRequest(method: .get, endpoint: path, completion: completion)
    }
    
    class private func loadPokeman(_ pokeman: PokemonResult, completion: @escaping (Result<[PokemanDetails], Error>) -> ()) {
        let group = DispatchGroup()
        
        var pokemans: [PokemanDetails] = []
        pokeman.pokemon.forEach { (item) in
            group.enter()
            loadPokemanDetail(from: item.pokemanDetailsURL) { (result) in
                switch result {
                case .failure(let e):
                    print("[APIManager] failed to load details with \(e.localizedDescription)")
                    group.leave()
                case .success(let pokeman):
                    pokemans.append(pokeman)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .global()) {
            completion(.success(pokemans))
        }
    }
    
    
}

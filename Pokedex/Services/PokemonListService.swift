//
//  PokemonListService.swift
//  Pokedex
//
//  Created by Gerson Arbigaus on 24/03/24.
//

import Foundation
import MiniService

protocol PokemonListServiceProtocol {
    func fetchPokeList() async throws -> PokemonListModel
}

final class PokemonListService: PokemonListServiceProtocol {
    private let service: APIServiceProtocol

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }

    func fetchPokeList() async throws -> PokemonListModel {
        do {
            let result: PokemonListModel = try await service.get(endpoint: "pokemon?limit=100000&offset=0")
            return result
        } catch(let error) {
            throw error
        }
    }
}

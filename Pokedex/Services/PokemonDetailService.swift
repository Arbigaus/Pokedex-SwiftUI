//
//  PokemonDetailService.swift
//  Pokedex
//
//  Created by Gerson Arbigaus on 25/03/24.
//

import Foundation
import MiniService

protocol PokemonDetailServiceProtocol {
    func fetchPokeDetail(id: Int) async throws -> PokemonDetailModel
}

final class PokemonDetailService: PokemonDetailServiceProtocol {
    private let service: APIServiceProtocol

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }

    func fetchPokeDetail(id: Int) async throws -> PokemonDetailModel {
        do {
            let result: PokemonDetailModel = try await service.get(endpoint: "pokemon/\(id)")
            return result
        } catch(let error) {
            throw error
        }
    }
}

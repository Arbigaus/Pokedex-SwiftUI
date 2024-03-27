//
//  PokemonListService.swift
//  Pokedex
//
//  Created by Gerson Arbigaus on 24/03/24.
//

import Foundation
import MiniService

protocol PokemonListServiceProtocol {
    func fetchAllPokemon() async throws -> PokemonListModel
    func fetchPokeList(page: Int) async throws -> PokemonListModel
}

final class PokemonListService: PokemonListServiceProtocol {
    private let service: APIServiceProtocol

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }

    func fetchAllPokemon() async throws -> PokemonListModel {
        do {
            let result: PokemonListModel = try await service.get(endpoint: "pokemon?limit=100000&offset=0")
            return result
        } catch(let error) {
            throw error
        }
    }

    func fetchPokeList(page: Int) async throws -> PokemonListModel {
        let limit = 20
        let offSet = limit * page
        let endpoint = "pokemon?limit=\(limit)&offset=\(offSet)"
        print(endpoint)
        do {
            let result: PokemonListModel = try await service.get(endpoint: endpoint)
            return result
        } catch(let error) {
            throw error
        }
    }
}

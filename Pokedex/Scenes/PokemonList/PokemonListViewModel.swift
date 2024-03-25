//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Gerson Arbigaus on 21/03/24.
//

import Foundation
import MiniService

class PokemonListViewModel: ObservableObject {
    private let service: PokemonListServiceProtocol = PokemonListService()

//    @Published var isLoading = true
    @Published var pokemonList = [PokemonListItemModel]()

    @MainActor
    func fetchPokemonList() async {
        do {
            let result = try await service.fetchPokeList()
            pokemonList = result.results
        }
        catch(let error) {
            print(error.localizedDescription)
        }

    }
}


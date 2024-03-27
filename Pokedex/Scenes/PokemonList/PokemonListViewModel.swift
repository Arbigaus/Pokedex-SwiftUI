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
    private var pokemonList = [PokemonListItemModel]()
    private var paginatedPokemonList = [PokemonListItemModel]()

    @Published var isLoading = false
    @Published var pokemonFilteredList = [PokemonListItemModel]()
    @Published var searchText = "" {
        didSet {
            searchPokemon()
        }
    }

    @MainActor
    func fetchPokemonList() async {
        isLoading = true
        do {
            let paginatedList = try await service.fetchPokeList()
            paginatedPokemonList = paginatedList.results
            pokemonFilteredList = paginatedPokemonList

            let allPokeList = try await service.fetchAllPokemon()
            pokemonList = allPokeList.results

            isLoading = false
        }
        catch(let error) {
            print(error.localizedDescription)
            isLoading = false
        }
    }

    private func searchPokemon() {
        if let id = Int(searchText) {
            self.pokemonFilteredList = self.pokemonList.filter { $0.id == id }
            return
        }
        self.pokemonFilteredList = searchText.isEmpty
            ? self.paginatedPokemonList
            : self.pokemonList.filter { $0.name.localizedStandardContains(searchText) }
    }
}

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

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
    private var page = 1

    @Published var isLoading = false
    @Published var isFinished = false
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
            let allPokeList = try await service.fetchAllPokemon()
            pokemonList = allPokeList.results

            isLoading = false
        }
        catch(let error) {
            print(error.localizedDescription)
            isLoading = false
        }
    }

    @MainActor
    func getNextPage() async {
        do {
            print("PAGE ==> \(page)")
            let paginatedList = try await service.fetchPokeList(page: page)
            paginatedPokemonList.append(contentsOf: paginatedList.results)
            pokemonFilteredList.append(contentsOf: paginatedList.results)
            page += 1

            if pokemonFilteredList.count == paginatedList.count {
                isFinished = true
            }
        }
        catch(let error) {
            print(error.localizedDescription)
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

//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Gerson Arbigaus on 21/03/24.
//

import Foundation

class PokemonListViewModel: ObservableObject {
    private let service: PokemonListServiceProtocol = PokemonListService()
    private var pokemonList = [PokemonListItemModel]()
    private var paginatedPokemonList = [PokemonListItemModel]()
    private var page = 1

    @Published var isLoading = false
    @Published var isFinished = false
    @Published var pokemonFilteredList = [PokemonListItemModel]()
    @Published var searchText: String = "" {
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

    private func isSearchingByType() -> PokemonTypeModel.PokeTypes? {
        return PokemonTypeModel.pokemonTypes.first(where: { $0.name == searchText.lowercased() } )
    }

    @MainActor
    private func fetchListByType(_ id: Int) async {
        do {
            let pokeByType = try await service.fetchPokeListByType(id)
            pokemonFilteredList = pokeByType.pokemon.map { poke in
                return PokemonListItemModel(name: poke.pokemon.name, url: poke.pokemon.url)
            }
        }
        catch(let error) {
            print(error.localizedDescription)
        }
    }

    private func searchPokemon() {
        isFinished = !searchText.isEmpty

        if let type = isSearchingByType() {
            Task {
                await fetchListByType(type.id)
            }
            return
        }

        if let id = Int(searchText) {
            self.pokemonFilteredList = self.pokemonList.filter { $0.id == id }
            return
        }
        self.pokemonFilteredList = searchText.isEmpty
            ? self.paginatedPokemonList
            : self.pokemonList.filter { $0.name.localizedStandardContains(searchText) }
    }
}

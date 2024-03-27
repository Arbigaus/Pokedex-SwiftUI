//
//  PokemonListModel+Extensions.swift
//  PokedexTests
//
//  Created by Gerson Arbigaus on 27/03/24.
//

import Foundation
@testable import Pokedex

extension PokemonListModel {
    static func mockPokeListModel() -> PokemonListModel {
        let results = [
            PokemonListItemModel(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25"),
            PokemonListItemModel(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1"),
            // Add more mock PokemonListItemModel instances as needed
        ]
        return PokemonListModel(count: results.count, next: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20", previous: nil, results: results)
    }
}

extension PokemonListModel: Equatable {
    public static func == (lhs: PokemonListModel, rhs: PokemonListModel) -> Bool {
        return lhs.results == rhs.results
        && lhs.count == rhs.count
        && lhs.next == rhs.next
        && lhs.previous == rhs.previous
    }
}

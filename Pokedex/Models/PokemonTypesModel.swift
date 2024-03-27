//
//  PokemonTypesModel.swift
//  Pokedex
//
//  Created by Gerson Arbigaus on 27/03/24.
//

import Foundation

struct PokemonTypeModel: Decodable {
    let id: Int
    let name: String
    let pokemon: [PokemonModel]

    struct PokemonModel: Decodable {
        let pokemon: PokemonItemModel
        let slot: Int
    }

    struct PokemonItemModel: Decodable {
        let name: String
        let url: String
    }
}

extension PokemonTypeModel {
    struct PokeTypes {
        let id: Int
        let name: String
    }

    static let pokemonTypes: [PokeTypes] = [
        PokeTypes(id: 1, name: "normal"),
        PokeTypes(id: 2, name: "fighting"),
        PokeTypes(id: 3, name: "flying"),
        PokeTypes(id: 4, name: "poison"),
        PokeTypes(id: 5, name: "ground"),
        PokeTypes(id: 6, name: "rock"),
        PokeTypes(id: 7, name: "bug"),
        PokeTypes(id: 8, name: "ghost"),
        PokeTypes(id: 9, name: "steel"),
        PokeTypes(id: 10, name: "fire"),
        PokeTypes(id: 11, name: "water"),
        PokeTypes(id: 12, name: "grass"),
        PokeTypes(id: 13, name: "electric"),
        PokeTypes(id: 14, name: "psychic"),
        PokeTypes(id: 15, name: "ice"),
        PokeTypes(id: 16, name: "dragon"),
        PokeTypes(id: 17, name: "dark"),
        PokeTypes(id: 18, name: "fairy")
    ]
}

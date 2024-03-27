//
//  PokemonDetailModel+Extension.swift
//  PokedexTests
//
//  Created by Gerson Arbigaus on 27/03/24.
//

import Foundation
@testable import Pokedex

extension PokemonDetailModel {
    static func mockPokemonDetailModel() -> PokemonDetailModel {
        return PokemonDetailModel(
            id: 25,
            name: "Pikachu",
            weight: 60,
            height: 40,
            types: [mockPokemonDetailTypeModel()],
            stats: [mockPokemonDetailStatModel()],
            sprites: mockPokemonDetailSpritesModel()
        )
    }

    static func mockPokemonDetailTypeModel() -> PokemonDetailTypeModel {
        return PokemonDetailTypeModel(
            slot: 1,
            type: PokemonDetailTypeModel.PokemonDetailType(name: "Electric", url: "https://pokeapi.co/api/v2/type/13/")
        )
    }

    static func mockPokemonDetailStatModel() -> PokemonDetailStatModel {
        return PokemonDetailStatModel(
            baseStat: 55,
            effort: 0,
            stat: PokemonDetailStatModel.PokemonDetailStat(name: "hp", url: "https://pokeapi.co/api/v2/stat/1/")
        )
    }

    static func mockPokemonDetailSpritesModel() -> PokemonDetailSpritesModel {
        return PokemonDetailSpritesModel(
            frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
            frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/25.png"
        )
    }
}

extension PokemonDetailModel: Equatable {
    public static func == (lhs: Pokedex.PokemonDetailModel, rhs: Pokedex.PokemonDetailModel) -> Bool {
        return lhs.id == rhs.id
    }
}

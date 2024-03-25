//
//  PokemonDetailModel.swift
//  Pokedex
//
//  Created by Gerson Arbigaus on 25/03/24.
//

import Foundation

struct PokemonDetailModel: Decodable, Identifiable {
    let id: Int
    let name: String
    let weight: Int
    let types: [PokemonDetailTypeModel]
    let stats: [PokemonDetailStatModel]
    let sprites: PokemonDetailSpritesModel
}

struct PokemonDetailTypeModel: Decodable {
    let slot: Int
    let type: PokemonDetailType

    struct PokemonDetailType: Decodable {
        let name: String
        let url: String
    }
}

struct PokemonDetailStatModel: Decodable {
    let baseStat: Int
    let effort: Int
    let stat: PokemonDetailStat

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }

    struct PokemonDetailStat: Decodable {
        let name: String
        let url: String
    }
}

struct PokemonDetailSpritesModel: Decodable {
    let frontDefault: String?
    let frontShiny: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

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

struct PokemonDetailTypeModel: Decodable, Hashable {
    let id = UUID()
    let slot: Int
    let type: PokemonDetailType

    enum CodingKeys: CodingKey {
        case slot, type
    }

    struct PokemonDetailType: Decodable {
        let name: String
        let url: String
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: PokemonDetailTypeModel, rhs: PokemonDetailTypeModel) -> Bool {
        return lhs.id == rhs.id
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

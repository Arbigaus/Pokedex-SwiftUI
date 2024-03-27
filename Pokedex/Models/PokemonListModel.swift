//
//
// PokemonListModel.swift
// Pokedex
//
// Created by Gerson Arbigaus on 21/03/24
//

import Foundation
import MiniService

struct PokemonListModel: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonListItemModel]

    init(count: Int, next: String?, previous: String?, results: [PokemonListItemModel]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

struct PokemonListItemModel: Decodable, Identifiable, Hashable {
    var id: Int? {
        url.idFromUrl()
    }
    let name: String
    let url: String

    private enum CodingKeys: String, CodingKey {
        case name, url
    }
}

extension PokemonListItemModel {
    var imgUrl: URL? {
        if let id = self.id {
            return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
        }
        return nil
    }
}

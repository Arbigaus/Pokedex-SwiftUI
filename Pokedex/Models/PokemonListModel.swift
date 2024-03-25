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
        pokeId()
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

    fileprivate func pokeId() -> Int? {
        let pattern = #"/(\d+)/?$"#
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(self.url.startIndex ..< self.url.endIndex, in: self.url)

        if let match = regex?.firstMatch(in: self.url, options: [], range: range),
           let range = Range(match.range(at: 1), in: self.url) {
            let number = Int(self.url[range])

            return number
        }

        return nil
    }
}

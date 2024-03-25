//
//  PokemonDetailService.swift
//  Pokedex
//
//  Created by Gerson Arbigaus on 25/03/24.
//

import Foundation
import MiniService

protocol PokemonDetailServiceProtocol {

}

final class PokemonDetailService: PokemonDetailServiceProtocol {
    private let service: APIServiceProtocol

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }
}

//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Gerson Arbigaus on 25/03/24.
//

import Foundation

final class PokemonDetailViewModel: ObservableObject {
    private let service: PokemonDetailServiceProtocol = PokemonDetailService()
    private let pokeId: Int
    
    @Published var pokeDetail: PokemonDetailModel?

    init(pokeId: Int) {
        self.pokeId = pokeId
    }

    @MainActor
    func fetchDetail() async {
        do {
            pokeDetail = try await service.fetchPokeDetail(id: pokeId)
        } catch(let error) {
            print(error)
        }
    }
}

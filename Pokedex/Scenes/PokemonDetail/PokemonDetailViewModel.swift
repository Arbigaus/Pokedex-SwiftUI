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
    private var displayShinyImage: Bool = false

    @Published var isLoading: Bool = false
    @Published var pokeDetail: PokemonDetailModel?
    @Published var asyncImageUrl: String = ""

    init(pokeId: Int) {
        self.pokeId = pokeId
    }

    @MainActor
    func fetchDetail() async {
        isLoading = true
        do {
            pokeDetail = try await service.fetchPokeDetail(id: pokeId)
            setAsyncImageUrl()
        } catch(let error) {
            print(error)
        }
        isLoading = false
    }

    func setAsyncImageUrl() {
        guard let frontShilyUrl = pokeDetail?.sprites.frontShiny,
              let frontDefaultUrl = pokeDetail?.sprites.frontDefault else { return }
        asyncImageUrl = displayShinyImage ?  frontShilyUrl : frontDefaultUrl
        displayShinyImage = !displayShinyImage
    }
}

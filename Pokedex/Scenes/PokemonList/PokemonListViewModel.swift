//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Gerson Arbigaus on 21/03/24.
//

import Foundation
import MiniService

class PokemonListViewModel: ObservableObject {
    private let service:APIServiceProtocol = APIService()

//    @Published var isLoading = true
    @Published var pokemonList = [PokemonListItemModel]()

    func fetchPokemonList() async {
        // TODO: Fetch list
       
    }
}


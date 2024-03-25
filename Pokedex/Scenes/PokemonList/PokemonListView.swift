//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Gerson Arbigaus on 21/03/24.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject private var viewModel = PokemonListViewModel()

    var body: some View {
        List(viewModel.pokemonList) { pokemon in
            HStack(spacing: 18) {
                AsyncImage(url: pokemon.imgUrl)
                    .frame(width: 50, height: 50)
                    .padding(6)
                Text(pokemon.name)
                    .font(.title)
                    .foregroundStyle(.black)
            }
        }
        .task {
            await viewModel.fetchPokemonList()
        }
        .navigationTitle("Pokémons")
    }
}

#Preview {
    PokemonListView()
}

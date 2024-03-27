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
        NavigationStack {
            List(viewModel.pokemonList) { pokemon in
                NavigationLink(value: pokemon) {
                    HStack(spacing: 18) {
                        AsyncImage(url: pokemon.imgUrl)
                            .frame(width: 50, height: 50)
                            .padding(6)
                        Text(pokemon.name.capitalized)
                            .font(.title)
                            .foregroundStyle(.primary)
                    }
                }
            }
            .listStyle(.inset)
            .navigationDestination(for: PokemonListItemModel.self) { poke in
                PokemonDetailView(viewModel: PokemonDetailViewModel(pokeId: poke.id ?? 0))
            }
            .isLoading(viewModel.isLoading)
            .navigationTitle("Pokémons")
        }
        .task {
            await viewModel.fetchPokemonList()
        }
    }
}

#Preview {
    PokemonListView()
}

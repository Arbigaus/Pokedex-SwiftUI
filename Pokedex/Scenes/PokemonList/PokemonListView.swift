//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Gerson Arbigaus on 21/03/24.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject private var viewModel: PokemonListViewModel

    init(viewModel: PokemonListViewModel = PokemonListViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.pokemonFilteredList, id: \.self) { pokemon in
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

                if !viewModel.isFinished {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .foregroundColor(.black)
                        .foregroundColor(.red)
                        .onAppear {
                            Task {
                                await viewModel.getNextPage()
                            }
                        }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Name, number or type")
            .listStyle(.inset)
            .navigationDestination(for: PokemonListItemModel.self) { poke in
                PokemonDetailView(viewModel: PokemonDetailViewModel(pokeId: poke.id ?? 0), typeName: $viewModel.searchText)
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

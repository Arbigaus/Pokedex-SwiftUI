//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Gerson Arbigaus on 25/03/24.
//

import SwiftUI

struct PokemonDetailView: View {
    @ObservedObject private var viewModel: PokemonDetailViewModel

    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 12) {
                AsyncImage(url: URL(string: viewModel.pokeDetail?.sprites.frontDefault ?? ""))
                    .frame(width: 80, height: 80)
                AsyncImage(url: URL(string: viewModel.pokeDetail?.sprites.frontShiny ?? ""))
                    .frame(width: 80, height: 80)
            }
            Text(viewModel.pokeDetail?.name ?? "Nome")
        }
        .task {
            await viewModel.fetchDetail()
        }
    }
}

#Preview {
    PokemonDetailView(viewModel: PokemonDetailViewModel(pokeId: 1))
}

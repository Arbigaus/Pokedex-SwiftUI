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
        VStack(alignment: .leading) {
            Text(viewModel.pokeDetail?.name.capitalized ?? "Pokemon")
                .font(.title)
            HStack(alignment: .center, spacing: 12) {
                AsyncImage(url: URL(string: viewModel.pokeDetail?.sprites.frontDefault ?? ""))
                    .frame(width: 120, height: 120)
                AsyncImage(url: URL(string: viewModel.pokeDetail?.sprites.frontShiny ?? ""))
                    .frame(width: 120, height: 120)
            }
            HStack {
                ForEach(viewModel.pokeDetail?.types ?? [], id: \.self) { type in
                    Text(type.type.name)
                        .background(Color.red)
                }
            }
        }
        .task {
            await viewModel.fetchDetail()
        }
    }
}

#Preview {
    PokemonDetailView(viewModel: PokemonDetailViewModel(pokeId: 1))
}

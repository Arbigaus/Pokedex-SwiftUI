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
        let mainType = viewModel.pokeDetail?.types.first
        let pokeDetail = viewModel.pokeDetail

        VStack(alignment: .center, spacing: 16) {
            HStack(alignment: .top, spacing: 12) {
                AsyncImage(url: URL(string: viewModel.pokeDetail?.sprites.frontDefault ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                    .padding(0)
                    .frame(width: 160, height: 160)
                    .background(Color(UIColor.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                VStack(alignment: .leading) {
                    Text("#\(pokeDetail?.id ?? 0)")
                        .font(.title)
                    Text(pokeDetail?.name.capitalized ?? "")
                        .font(.title)
                        .foregroundStyle(Color(UIColor.systemBackground))

                    HStack(spacing: 4) {
                        ForEach(pokeDetail?.types ?? [], id: \.self) { type in
                            let name = type.type.name.capitalized
                            Text(name)
                                .font(.headline)
                                .padding([.leading, .trailing], 8)
                                .padding([.bottom, .top], 6)
                                .background(Color(name))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
            }

            VStack(alignment: .leading) {
                ForEach(pokeDetail?.stats ?? [], id: \.id) { stat in
                    HStack(alignment: .firstTextBaseline) {
                        Text("\(stat.stat.name.capitalized):")
                            .fontWeight(.bold)
                        Text("\(stat.baseStat)")
                        Spacer()
                    }

                }
                HStack(alignment: .firstTextBaseline) {
                    Text("Height:")
                        .fontWeight(.bold)
                    Text("\(pokeDetail?.height ?? 0)")
                    Spacer()
                }
                HStack(alignment: .firstTextBaseline) {
                    Text("Weight:")
                        .fontWeight(.bold)
                    Text("\(pokeDetail?.weight ?? 0)")
                    Spacer()
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding([.top], 16)
            .padding([.leading, .trailing], 12)
            .background(Color(UIColor.systemBackground))
            .clipShape(.rect(
                topLeadingRadius: 16,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 16
            ))

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color("\(mainType?.type.name.capitalized ?? "")Background"))
        .task {
            await viewModel.fetchDetail()
        }
    }
}

#Preview {
    PokemonDetailView(viewModel: PokemonDetailViewModel(pokeId: 1))
}

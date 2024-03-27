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

        ZStack {
            VStack(alignment: .center, spacing: 16) {
                HeaderView(pokeDetail: pokeDetail,
                           asyncImageUrl: viewModel.asyncImageUrl) {
                    viewModel.setAsyncImageUrl()
                }
                StatsView(pokeDetail: pokeDetail)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all, edges: .bottom)
            .background(Color("\(mainType?.type.name.capitalized ?? "")Background"))
            .isLoading(viewModel.isLoading)
        }
        .task {
            await viewModel.fetchDetail()
        }
    }

    private struct HeaderView: View {
        let pokeDetail: PokemonDetailModel?
        let asyncImageUrl: String
        let tapGesture: () -> Void

        var body: some View {
            HStack(alignment: .top, spacing: 12) {
                AsyncImage(url: URL(string: asyncImageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .padding(0)
                .frame(width: 160, height: 160)
                .background(Color(UIColor.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .onTapGesture {
                    tapGesture()
                }

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
        }
    }

    private struct StatsView: View {
        let pokeDetail: PokemonDetailModel?

        func stats(title: String, value: String) -> some View {
            return HStack(alignment: .firstTextBaseline) {
                Text("\(title):")
                    .font(.system(size: 20, weight: .bold))
                Spacer()
                Text(value)
                    .font(.system(size: 20))
            }
            .padding([.bottom], 2)
        }

        var body: some View {
            VStack(alignment: .leading) {
                ForEach(pokeDetail?.stats ?? [], id: \.id) { stat in
                    stats(title: stat.stat.name.capitalized, value: "\(stat.baseStat)")
                }
                stats(title: "Height", value: "\(pokeDetail?.height ?? 0)")
                stats(title: "Weight", value: "\(pokeDetail?.weight ?? 0)")
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
    }
}

#Preview {
    PokemonDetailView(viewModel: PokemonDetailViewModel(pokeId: 1))
}

//
//  MockApiService.swift
//  PokedexTests
//
//  Created by Gerson Arbigaus on 24/03/24.
//

import Foundation
import MiniService
@testable import Pokedex

enum ExpectResponse {
    case success
    case failure(Error)
}

final class MockAPIService: APIServiceProtocol {
    static var urlBase: String?
    var expected: ExpectResponse?

    static func setBaseURL(_ baseUrl: String) {
        self.urlBase = baseUrl
    }

    func insertHeader(_ headers: [String : String]?) -> APIServiceProtocol {
        return self
    }

    func post<ResponseType, PayloadType>(endpoint: String, payload: PayloadType) async throws -> ResponseType where ResponseType : Decodable, PayloadType : Encodable {
        let mockData = PokemonListModel.mockPokeListModel()
        if let response = mockData as? ResponseType {
            return response
        }
        throw NSError(domain: "Some error", code: 0)
    }

    func put<ResponseType, PayloadType>(endpoint: String, payload: PayloadType) async throws -> ResponseType where ResponseType : Decodable, PayloadType : Encodable {
        let mockData = PokemonListModel.mockPokeListModel()
        if let response = mockData as? ResponseType {
            return response
        }
        throw NSError(domain: "Some error", code: 0)
    }

    func get<ResponseType>(endpoint: String) async throws -> ResponseType where ResponseType : Decodable {

        switch expected {
        case .success:
            let mockData = PokemonListModel.mockPokeListModel()
            if let response = mockData as? ResponseType {
                return response
            }
            throw NSError(domain: "Some error", code: 0)
        case .failure(let error):
            throw error
        case .none:
            throw NSError(domain: "Some error", code: 0)
        }


    }
}

extension PokemonListModel {
    static func mockPokeListModel() -> PokemonListModel {
        let results = [
            PokemonListItemModel(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25"),
            PokemonListItemModel(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1"),
            // Add more mock PokemonListItemModel instances as needed
        ]
        return PokemonListModel(count: results.count, next: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20", previous: nil, results: results)
    }
}

extension PokemonListModel: Equatable {
    public static func == (lhs: PokemonListModel, rhs: PokemonListModel) -> Bool {
        return lhs.results == rhs.results
            && lhs.count == rhs.count
            && lhs.next == rhs.next
            && lhs.previous == rhs.previous
    }
}

extension PokemonListItemModel: Equatable {
    public static func == (lhs: PokemonListItemModel, rhs: PokemonListItemModel) -> Bool {
        return lhs.id == rhs.id
                && lhs.name == rhs.name
                && lhs.url == rhs.url
                && lhs.imgUrl == rhs.imgUrl
    }
    

}

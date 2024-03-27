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
    case success(Any)
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
        case .success(let mockData):
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



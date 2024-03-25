//
//  PokemonListServiceTest.swift
//  PokedexTests
//
//  Created by Gerson Arbigaus on 24/03/24.
//

import XCTest
import MiniService
@testable import Pokedex

final class PokemonListServiceTest: XCTestCase {
    var mockService: APIServiceProtocol!
    var service: PokemonListService!

    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
        service = PokemonListService(service: mockService)
    }

    override func tearDown() {
        mockService = nil
        service = nil

        super.tearDown()
    }

    func test_successFetchPokeList() async {
        do {
            let result = try await service.fetchPokeList()

            // Then
            XCTAssertNotNil(result, "Pokemon list should not be nil")
            XCTAssertEqual(result, PokemonListModel.mock())
        } catch {gst
            XCTFail("Fetching Pokemon list should not throw an error")
        }
    }

}

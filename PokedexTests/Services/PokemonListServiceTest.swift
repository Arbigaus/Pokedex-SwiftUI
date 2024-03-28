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
    var mockService: MockAPIService!
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
        let data = PokemonListModel.mockPokeListModel()
        mockService.expected = .success(data)
        do {
            let result = try await service.fetchPokeList(page: 1)

            XCTAssertNotNil(result, "Pokemon list should not be nil")
            XCTAssertEqual(result, data)
        } catch {
            XCTFail("Fetching Pokemon list should not throw an error")
        }
    }

    func test_failureFetchPokeList() async {
        let nsError = NSError(domain: "Some Error", code: 1)
        mockService.expected = .failure(nsError)

        do {
            let _ = try await service.fetchPokeList(page: 1)

            XCTFail("Returned susccess, exptect error instead")
        } catch(let error) {
            XCTAssertEqual(error as NSError, nsError)
        }
    }

}

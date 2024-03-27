//
//  PokemonDetailServiceTest.swift
//  PokedexTests
//
//  Created by Gerson Arbigaus on 27/03/24.
//

import XCTest
@testable import Pokedex

final class PokemonDetailServiceTest: XCTestCase {
    var mockService: MockAPIService!
    var service: PokemonDetailService!

    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
        service = PokemonDetailService(service: mockService)
    }

    override func tearDown() {
        mockService = nil
        service = nil

        super.tearDown()
    }

    func test_fetchSuccessPokeDetail() async {
        let data = PokemonDetailModel.mockPokemonDetailModel()
        mockService.expected = .success(data)
        do {
            let result: PokemonDetailModel = try await service.fetchPokeDetail(id: 25)

            XCTAssertNotNil(result, "Pokemon list should not be nil")
            XCTAssertEqual(result, data)
        } catch {
            XCTFail("Fetching Pokemon list should not throw an error")
        }
    }

    func test_failurePokeDetail() async {
        let nsError = NSError(domain: "Some Error", code: 1)
        mockService.expected = .failure(nsError)

        do {
            let _ = try await service.fetchPokeDetail(id: 25)

            XCTFail("Returned susccess, exptect error instead")
        } catch(let error) {
            XCTAssertEqual(error as NSError, nsError)
        }
    }

}

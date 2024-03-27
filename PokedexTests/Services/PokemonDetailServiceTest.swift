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



}

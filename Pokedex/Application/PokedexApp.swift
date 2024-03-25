//
//
// PokedexApp.swift
// Pokedex
//
// Created by Gerson Arbigaus on 21/03/24
//
        
import MiniService
import SwiftUI

@main
struct PokedexApp: App {
    var body: some Scene {
        WindowGroup {
            PokemonListView()
                .onAppear {
                    checkFirstLaunch()
                }
        }
    }

    func checkFirstLaunch() {
        let key = "isFirstLaunch"
        let isFirstLaunch = UserDefaults.standard.bool(forKey: key)
        if !isFirstLaunch {
            UserDefaults.standard.set(true, forKey: key)
            APIService.setBaseURL("https://pokeapi.co/api/v2/")
            UserDefaults.standard.synchronize()
        }
    }
}

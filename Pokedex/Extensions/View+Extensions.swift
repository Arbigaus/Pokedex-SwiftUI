//
//  View+Extensions.swift
//  Pokedex
//
//  Created by Gerson Arbigaus on 26/03/24.
//

import SwiftUI

public extension View {

    /**
     Show loading in the view

     - parameters:
     - condition: The boolean to confirm if has to show loading

     This function will show loading when the parameter is true
     */
    @ViewBuilder func isLoading(_ condition: Bool) -> some View {
        if condition {
            ProgressView()
        } else {
            self
        }
    }
}

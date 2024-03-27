//
//  String+Extensions.swift
//  Pokedex
//
//  Created by Gerson Arbigaus on 27/03/24.
//

import Foundation

extension String {
    func idFromUrl() -> Int? {
        let pattern = #"/(\d+)/?$"#
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(self.startIndex ..< self.endIndex, in: self)

        if let match = regex?.firstMatch(in: self, options: [], range: range),
           let range = Range(match.range(at: 1), in: self) {
            let number = Int(self[range])

            return number
        }

        return nil
    }
}

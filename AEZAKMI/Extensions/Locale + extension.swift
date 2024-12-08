//
//  Locale + extension.swift
//  Countries
//
//  Created by Георгий Глухов on 08.12.2024.
//

import Foundation

extension Locale {
    static func getPreferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
}

//
//  Country + Translations.swift
//  Countries
//
//  Created by Георгий Глухов on 08.12.2024.
//

import Foundation

struct Translation: Hashable, Decodable {
    let official: String
    let common: String
}

extension [String: Translation] {
    func localizedName(for locale: Locale = Locale.getPreferredLocale()) -> String? {
        let languageCode = locale.language.languageCode?.identifier(.alpha3) ?? "en"
        return self[languageCode]?.common
    }

    func localizedOfficialName(for locale: Locale = Locale.getPreferredLocale()) -> String? {
        let languageCode = locale.language.languageCode?.identifier(.alpha3) ?? "en"
        return self[languageCode]?.official
    }
}

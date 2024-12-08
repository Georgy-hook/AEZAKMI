//
//  Country+Decodable.swift
//  Countries
//
//  Created by Георгий Глухов on 05.12.2024.
//

import CoreLocation
import Foundation

extension Country: Decodable {
    init(from decoder: Decoder) throws {
        let root = try decoder.container(keyedBy: CodingKeys.self)

        name = try root.decode(Name.self, forKey: .name)
        area = try root.decode(Double.self, forKey: .area)
        population = try root.decode(Int.self, forKey: .population)
        flags = try root.decode(Flag.self, forKey: .flags)
        code = try root.decode(String.self, forKey: .code)

        let latlng = try root.decode([CLLocationDegrees].self, forKey: .location)
        location = .init(latitude: latlng[0], longitude: latlng[1])

        continent = try .init(
            rawValue: root
                .decode([String].self, forKey: .continent)
                .first ?? ""
        ) ?? .none

        capital = try? .init(from: decoder)

        languages = try? root
            .decode([String: String].self, forKey: .languages)
            .map(\.value)

        let currencies = try? root
            .decode([String: Currency].self, forKey: .currencies)
        self.currencies = (currencies?.map { Currency(name: $0.value.name, symbol: $0.value.symbol, ISO4217: $0.key) }) ?? []

        timezones = try? root.decode([String].self, forKey: .timezones)

        translations = try? root.decode([String: Translation].self, forKey: .translations)
    }

    enum CodingKeys: String, CodingKey {
        case name
        case continent = "continents"
        case capital
        case location = "latlng"
        case borders
        case tlds = "tld"
        case code = "cca3"
        case currencies
        case languages
        case area
        case population
        case flags
        case timezones
        case translations
    }
}

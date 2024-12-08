//
//  Country+Samples.swift
//  Countries
//
//  Created by Георгий Глухов on 05.12.2024.
//

import Foundation

extension Country {
    // INFO: useful for SwiftUI previews rendering.
    static let italy = Country(
        name: .init(common: "Italy", official: "Italian Republic"),
        continent: .europe,
        capital: .init(
            name: "Rome",
            location: .init(latitude: 41.9, longitude: 12.48)
        ),
        location: .init(latitude: 42.83333333, longitude: 12.83333333),
        code: "ITA",
        currencies: [.init(name: "Euro", symbol: "€", ISO4217: "EUR")],
        languages: ["Italian"],
        area: 301_336.0,
        population: 59_554_023,
        flags: .init(
            png: URL(string: "https://flagcdn.com/w320/it.png")!,
            svg: URL(string: "https://flagcdn.com/it.svg")!
        ),
        timezones: [""],
        translations: ["": Translation(official: "", common: "")]
    )
}

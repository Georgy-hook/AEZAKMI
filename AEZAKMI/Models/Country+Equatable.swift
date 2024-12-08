//
//  Country+Equatable.swift
//  Countries
//
//  Created by Георгий Глухов on 05.12.2024.
//

import Foundation

extension Country: Equatable {
    static func == (lhs: Country, rhs: Country) -> Bool {
        lhs.name == rhs.name &&
            lhs.continent == rhs.continent &&
            lhs.capital == rhs.capital &&
            lhs.location == rhs.location &&
            lhs.currencies == rhs.currencies &&
            lhs.languages == rhs.languages &&
            lhs.area == rhs.area &&
            lhs.population == rhs.population &&
            lhs.flags == rhs.flags &&
            lhs.timezones == rhs.timezones &&
            lhs.translations == rhs.translations
    }
}

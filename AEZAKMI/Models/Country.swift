//
//  Country.swift
//  Countries
//
//  Created by Георгий Глухов on 08/12/24.
//

import CoreLocation
import Foundation

struct Country: Identifiable, Hashable {
    let id = UUID()
    let name: Name
    let continent: Continent
    let capital: Capital?
    let location: CLLocationCoordinate2D
    let code: String
    let currencies: [Currency]
    let languages: [String]?
    let area: Double
    let population: Int
    let flags: Flag
    let timezones: [String]?
    let translations: [String: Translation]?
    init(
        name: Name,
        continent: Continent,
        capital: Capital? = nil,
        location: CLLocationCoordinate2D,
        code: String,
        currencies: [Currency],
        languages: [String]? = nil,
        area: Double,
        population: Int,
        flags: Flag,
        timezones: [String]? = nil,
        translations: [String: Translation]
    ) {
        self.name = name
        self.continent = continent
        self.capital = capital
        self.location = location
        self.code = code
        self.currencies = currencies
        self.languages = languages
        self.area = area
        self.population = population
        self.flags = flags
        self.timezones = timezones
        self.translations = translations
    }
}

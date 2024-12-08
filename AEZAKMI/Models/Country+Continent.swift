//
//  Country+Continent.swift
//  Countries
//
//  Created by Георгий Глухов on 08/12/24.
//

import Foundation

extension Country {
    enum Continent: String, CaseIterable, Hashable, Codable {
        case all
        case none
        case europe = "Europe"
        case africa = "Africa"
        case asia = "Asia"
        case oceania = "Oceania"
        case southAmerica = "South America"
        case northAmerica = "North America"
        case antarctica = "Antarctica"

        var name: String {
            switch self {
            case .all:
                String(localized: "All")
            case .europe:
                String(localized: "Europe")
            case .africa:
                String(localized: "Africa")
            case .asia:
                String(localized: "Asia")
            case .oceania:
                String(localized: "Oceania")
            case .southAmerica:
                String(localized: "South America")
            case .northAmerica:
                String(localized: "North America")
            case .antarctica:
                String(localized: "Antarctica")
            case .none:
                ""
            }
        }
    }
}

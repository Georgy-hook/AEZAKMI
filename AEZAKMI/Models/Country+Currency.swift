//
//  Country+Currency.swift
//  Countries
//
//  Created by Георгий Глухов on 08/12/24.
//

import Foundation

extension Country {
    struct Currency: Decodable, Hashable, Equatable {
        var name: String
        var symbol: String
        var ISO4217: String?

        enum CodingKeys: CodingKey {
            case name
            case symbol
        }
    }
}

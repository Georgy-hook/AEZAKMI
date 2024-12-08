//
//  Country+Name.swift
//  Countries
//
//  Created by Георгий Глухов on 08/12/24.
//

import Foundation

extension Country {
    struct Name: Codable, Hashable, Equatable {
        var common: String
        var official: String

        enum CodingKeys: CodingKey {
            case official
            case common
        }
    }
}

//
//  Country+Flag.swift
//  Countries
//
//  Created by Георгий Глухов on 08/12/24.
//

import Foundation

extension Country {
    struct Flag: Codable, Hashable, Equatable {
        var png: URL
        var svg: URL

        enum CodingKeys: CodingKey {
            case png
            case svg
        }
    }
}

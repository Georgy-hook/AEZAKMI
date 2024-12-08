//
//  Country+Error.swift
//  Countries
//
//  Created by Георгий Глухов on 05.12.2024.
//

import Foundation

extension Country {
    enum Errors: Error {
        case missingKey(String)
        case notImplemented
    }
}

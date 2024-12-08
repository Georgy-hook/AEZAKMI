//
//  RestCountries.swift
//  Countries
//
//  Created by Георгий Глухов on 08.12.2024.
//

import Foundation

enum RestCountries {
    case all
    case name(String)
    case code(String)

    private var baseURL: String {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String else {
            fatalError("Base URL not set in Info.plist")
        }
        return baseURL
    }

    private var apiVersion: String {
        guard let version = Bundle.main.object(forInfoDictionaryKey: "API_VERSION") as? String else {
            fatalError("API Version not set in Info.plist")
        }
        return version
    }

    var url: URL {
        var final = URLComponents()

        final.scheme = URL(string: baseURL)?.scheme

        final.host = URL(string: baseURL)?.host
        final.path = "/" + apiVersion + "/"
        switch self {
        case .all:
            final.path += "all"
        case let .name(name):
            let parameter = URLQueryItem(name: "fullText", value: "true")
            final.path += "name/" + name
            final.queryItems = [parameter]
        case let .code(code):
            final.path += "alpha/" + code
        }

        guard let url = final.url else {
            fatalError("Invalid URL components")
        }

        return url
    }
}

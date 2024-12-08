//
//  NetworkingError.swift
//  Countries
//
//  Created by Георгий Глухов on 08.12.2024.
//

import Foundation

enum NetworkingError: LocalizedError {
    case requestFailed(statusCode: Int)
    case invalidResponse
    case decodingFailed
    case networkFailure(URLError)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case let .requestFailed(statusCode):
            "Request failed with status code \(statusCode)."
        case .invalidResponse:
            "Invalid response from the server."
        case .decodingFailed:
            "Failed to decode the server response."
        case let .networkFailure(urlError):
            "Network error: \(urlError.localizedDescription)."
        case let .unknown(error):
            "An unknown error occurred: \(error.localizedDescription)."
        }
    }
}

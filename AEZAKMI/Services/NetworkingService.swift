//
//  NetworkingService.swift
//  Countries
//
//  Created by Георгий Глухов on 05.12.2024.
//

import Foundation

actor NetworkingService {
    func fetchObject<T: Decodable>(for url: URL) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkingError.invalidResponse
            }

            guard httpResponse.statusCode == 200 else {
                throw NetworkingError.requestFailed(statusCode: httpResponse.statusCode)
            }

            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkingError.decodingFailed
            }
        } catch let urlError as URLError {
            throw NetworkingError.networkFailure(urlError)
        } catch {
            throw NetworkingError.unknown(error)
        }
    }
}

//
//  CountriesViewViewModel.swift
//  Countries
//
//  Created by Георгий Глухов on 05.12.2024.
//

import CoreData
import Foundation
import SwiftUI

@MainActor
final class CountriesViewViewModel: ObservableObject {
    let networkingService: NetworkingService
    @Published var errorMessage: String?

    @Published private(set) var countries: [Country] = []
    @Published private(set) var filteredCountries: [Country] = []

    init(networkingService: NetworkingService) {
        self.networkingService = networkingService

        Task {
            await loadCountries()
            filterCountries(by: .all)
        }
    }

    func loadCountries() async {
        do {
            countries = try await networkingService.fetchObject(for: RestCountries.all.url)
        } catch let error as NetworkingError {
            await handleError(error)
        } catch {
            await handleError(.unknown(error))
        }
    }

    private func handleError(_ error: NetworkingError) async {
        await MainActor.run {
            errorMessage = error.localizedDescription
        }
    }

    func getCountry(byCode code: String) -> Country? {
        countries.first(where: { $0.code == code })
    }

    func filterCountries(by continent: Country.Continent) {
        if continent == .all {
            filteredCountries = countries
        } else {
            filteredCountries = countries.filter { $0.continent == continent }
        }
    }

    func filterCountries(by text: String) {
        filteredCountries = countries.filter { $0.name.common.localizedCaseInsensitiveContains(text) }
    }

    func filterCountries(by favoriteCountries: [FavoriteCountry]) {
        let favoriteCodes = favoriteCountries.map { $0.code }

        filteredCountries = filteredCountries.filter { favoriteCodes.contains($0.code) }
    }
}

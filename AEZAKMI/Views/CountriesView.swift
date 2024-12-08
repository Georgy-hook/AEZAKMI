//
//  CountriesView.swift
//  Countries
//
//  Created by Георгий Глухов on 05.12.2024.
//

import SwiftUI

struct CountriesView: View {
    @StateObject var countriesViewViewModel: CountriesViewViewModel
    @Environment(\.managedObjectContext) private var viewContext

    @State private var searchField: String = ""
    @State private var selectedContinent: Country.Continent = .all
    @State private var showOnlyFavoriteCountries: Bool = false

    @FetchRequest(
        entity: FavoriteCountry.entity(),
        sortDescriptors: [],
        animation: .default
    )
    private var favoriteCountries: FetchedResults<FavoriteCountry>

    var body: some View {
        NavigationStack {
            Group {
                if !countriesViewViewModel.countries.isEmpty {
                    if !countriesViewViewModel.filteredCountries.isEmpty {
                        List(countriesViewViewModel.filteredCountries) { country in
                            NavigationLink(value: country) {
                                CountryRow(
                                    country: country,
                                    isFavorite: isFavorite(country: country),
                                    onFavoriteToggle: { country in
                                        toggleFavoriteState(for: country)
                                    }
                                )
                            }
                        }
                        .navigationDestination(for: Country.self) { country in
                            CountryDetailed(country: country, isFavorite: isFavorite(country: country))
                        }
                    } else {
                        Text("No countries found")
                            .foregroundColor(Color("secondaryText"))
                    }
                } else {
                    ProgressView("Loading")
                        .progressViewStyle(CircularProgressViewStyle(tint: Color("progressColor")))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("defaultBackgroundColor"))
                }
            }
            .background(Color("primaryBackground"))
            .navigationTitle("Countries")
            .searchable(
                text: $searchField,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Country Search"
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Toggle("Favorite only", isOn: $showOnlyFavoriteCountries)
                            .toggleStyle(.button)

                        Picker("Continents", selection: $selectedContinent) {
                            ForEach(Country.Continent.allCases, id: \.self) { continent in
                                if continent != .none {
                                    Text(continent.name).tag(continent)
                                }
                            }
                        }
                    } label: {
                        Text(selectedContinent.name)
                            .foregroundColor(Color("AccentColor"))
                    }
                }
            }
            .background(Color("secondaryBackground"))
            .refreshable {
                await countriesViewViewModel.loadCountries()
            }
            .alert(isPresented: Binding<Bool>(
                get: { countriesViewViewModel.errorMessage != nil },
                set: { _ in countriesViewViewModel.errorMessage = nil }
            )) {
                Alert(
                    title: Text("Error"),
                    message: Text(countriesViewViewModel.errorMessage ?? ""),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .navigationViewStyle(.stack)
        .onChange(of: searchField) {
            if $0.isEmpty {
                filterCountriesByContinent(isFavoriteFilterEnabled: showOnlyFavoriteCountries)
            } else {
                countriesViewViewModel.filterCountries(by: $0)
            }
        }
        .onChange(of: selectedContinent) { _ in
            filterCountriesByContinent(isFavoriteFilterEnabled: showOnlyFavoriteCountries)
        }
        .onChange(of: showOnlyFavoriteCountries) {
            filterCountriesByContinent(isFavoriteFilterEnabled: $0)
        }
    }
}

extension CountriesView {
    private func isFavorite(country: Country) -> Bool {
        favoriteCountries.contains { $0.code == country.code }
    }

    private func toggleFavoriteState(for country: Country) {
        if let storedCountryCode = favoriteCountries.first(where: { $0.code == country.code }) {
            removeFavorite(storedCountryCode: storedCountryCode)
        } else {
            addFavorite(countryCode: country.code)
        }

        viewContext.saveContext()

        if showOnlyFavoriteCountries == true {
            countriesViewViewModel.filterCountries(by: favoriteCountries.map { $0 })
        }
    }

    private func addFavorite(countryCode: String) {
        withAnimation {
            let newFavoriteCode = FavoriteCountry(context: viewContext)
            newFavoriteCode.code = countryCode
        }
    }

    private func removeFavorite(storedCountryCode: FavoriteCountry) {
        withAnimation {
            viewContext.delete(storedCountryCode)
        }
    }
}

extension CountriesView {
    private func filterCountriesByContinent(isFavoriteFilterEnabled: Bool) {
        if isFavoriteFilterEnabled == false {
            countriesViewViewModel.filterCountries(by: selectedContinent)
        } else {
            countriesViewViewModel.filterCountries(by: selectedContinent)
            countriesViewViewModel.filterCountries(by: favoriteCountries.map { $0 })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView(countriesViewViewModel: CountriesViewViewModel(networkingService: NetworkingService()))
    }
}

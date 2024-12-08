//
//  CountryDetailed.swift
//  Countries
//
//  Created by Георгий Глухов on 05.12.2024.
//

import MapKit
import SwiftUI

struct CountryDetailed: View {
    @StateObject private var viewModel: CountryDetailedViewModel
    @State private var mapFullScreenPresented = false

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: FavoriteCountry.entity(),
        sortDescriptors: [],
        animation: .default
    )
    private var favoriteCountries: FetchedResults<FavoriteCountry>

    init(country: Country, isFavorite: Bool) {
        _viewModel = StateObject(wrappedValue:
            CountryDetailedViewModel(
                country: country,
                isFavorite: isFavorite
            )
        )
    }

    var body: some View {
        List {
            flagSection
            nameSection
            capitalSection
            populationSection
            areaSection
            currencySection
            languageSection
            timezonesSection
            mapSection
        }
        .listStyle(.insetGrouped)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.country.translations?.localizedName() ?? viewModel.country.name.common)
        .background(Color("primaryBackground"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button(action: {
                        toggleFavoriteState(for: viewModel.country)
                    }) {
                        Image(systemName: viewModel.isFavoriteCountry ? "star.fill" : "star")
                            .foregroundColor(Color("gold"))
                    }

                    ShareLink(
                        item: viewModel.shareableContent,
                        subject: Text("Country Information"),
                        message: Text("Learn more about \(viewModel.country.name.common)."),
                        preview: SharePreview(viewModel.country.name.common)
                    ) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $mapFullScreenPresented) {
            FullScreenMap(location: viewModel.country.location, span: viewModel.region.span)
        }
    }
}

extension CountryDetailed {
    private var flagSection: some View {
        Section {
            FlagImage(url: viewModel.country.flags.png)
                .listRowInsets(EdgeInsets())
        }
        .background(Color("secondaryBackground"))
    }

    private var nameSection: some View {
        Section {
            Text(viewModel.country.translations?.localizedOfficialName() ?? viewModel.country.name.official)
                .font(.title2)
                .italic()
                .foregroundColor(Color("primaryText"))
        } header: {
            Text("Official Name")
                .font(.callout)
                .foregroundColor(Color("secondaryText"))
        }
    }

    @ViewBuilder
    private var capitalSection: some View {
        if let capitalName = viewModel.country.capital?.name {
            Section {
                Text(capitalName)
                    .font(.title2)
                    .italic()
                    .foregroundColor(Color("primaryText"))
            } header: {
                Text("Capital")
                    .font(.callout)
                    .foregroundColor(Color("secondaryText"))
            }
        }
    }

    @ViewBuilder
    private var languageSection: some View {
        if let languages = viewModel.country.languages {
            Section {
                ForEach(languages, id: \.self) { language in
                    Text(language)
                        .font(.title3)
                        .foregroundColor(Color("primaryText"))
                }
            } header: {
                Text("Languages")
                    .font(.callout)
                    .foregroundColor(Color("secondaryText"))
            }
        }
    }

    private var populationSection: some View {
        Section {
            Text("\(viewModel.country.population) people")
                .font(.body)
                .foregroundColor(Color("primaryText"))
        } header: {
            Text("Population")
                .font(.callout)
                .foregroundColor(Color("secondaryText"))
        }
    }

    private var areaSection: some View {
        Section {
            Text(viewModel.formattedArea)
                .font(.body)
                .foregroundColor(Color("primaryText"))
        } header: {
            Text("Area")
                .font(.callout)
                .foregroundColor(Color("secondaryText"))
        }
    }

    private var mapSection: some View {
        Section {
            Map(coordinateRegion: .constant(viewModel.region), interactionModes: .zoom)
                .frame(minHeight: 400)
                .listRowInsets(EdgeInsets())
                .onTapGesture {
                    mapFullScreenPresented.toggle()
                }
                .background(Color("secondaryBackground"))
        } header: {
            Text("Map")
                .font(.callout)
                .foregroundColor(Color("secondaryText"))
        }
    }

    @ViewBuilder
    private var currencySection: some View {
        if !viewModel.country.currencies.isEmpty {
            Section {
                ForEach(viewModel.country.currencies, id: \.name) { currency in
                    HStack {
                        Text(currency.name)
                        Spacer()
                        Text(currency.ISO4217 ?? "")
                        Spacer()
                        Text(currency.symbol)
                    }.font(.title3)
                }
            } header: {
                Text("Currencies")
                    .font(.callout)
                    .foregroundColor(Color("secondaryText"))
            }
        }
    }

    @ViewBuilder
    private var timezonesSection: some View {
        if let timezones = viewModel.country.timezones {
            Section {
                ForEach(timezones, id: \.self) { timezone in
                    Text(timezone)
                }
            } header: {
                Text("Timezones")
                    .font(.callout)
            }
        }
    }
}

extension CountryDetailed {
    private func toggleFavoriteState(for country: Country) {
        viewModel.toggleFavoriteCountry()

        if let storedCountryCode = favoriteCountries.first(where: { $0.code == country.code }) {
            removeFavorite(storedCountryCode: storedCountryCode)
        } else {
            addFavorite(countryCode: country.code)
        }

        viewContext.saveContext()
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

struct CountryDetailed_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CountryDetailed(country: .italy, isFavorite: true)
        }
    }
}

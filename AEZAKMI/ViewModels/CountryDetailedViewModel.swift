import Foundation
import MapKit

@MainActor
final class CountryDetailedViewModel: ObservableObject {
    let country: Country
    private(set) var isFavoriteCountry: Bool

    var shareableContent: String {
        """
        Country: \(country.name.common)
        Official Name: \(country.name.official)
        Population: \(formattedPopulation) people
        Area: \(formattedArea)
        Capital: \(country.capital?.name ?? "Unknown")
        """
    }

    init(country: Country, isFavorite: Bool) {
        self.country = country
        self.isFavoriteCountry = isFavorite
    }

    var formattedPopulation: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: country.population)) ?? "\(country.population)"
    }

    var formattedArea: String {
        let measure = Measurement<UnitArea>(value: country.area, unit: .squareKilometers)
        return measure.formatted()
    }

    var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: country.location,
            span: country.span
        )
    }

    func toggleFavoriteCountry() {
        isFavoriteCountry.toggle()
    }
}

//
//  CountryRow.swift
//  Countries
//
//  Created by Георгий Глухов on 05.12.2024.
//

import SwiftUI

struct CountryRow: View {
    let country: Country
    let isFavorite: Bool
    var onFavoriteToggle: (Country) -> Void

    var body: some View {
        HStack {
            FlagImage(url: country.flags.png)
                .frame(width: 80, height: 80)
                .padding(.trailing)

            VStack(alignment: .leading, spacing: 8) {
                Text(country.translations?.localizedName() ?? country.name.common)
                    .font(.headline)
                    .foregroundColor(Color("primaryText"))
                Text(country.continent.name)
                    .foregroundColor(Color("secondaryText"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.trailing)

            Button(action: {
                onFavoriteToggle(country)
            }) {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(Color("gold"))
            }
            .buttonStyle(PlainButtonStyle())
            .frame(width: 40, height: 40)
        }
        .background(Color("primaryBackground"))
        .cornerRadius(10)
        .padding(.vertical, 4)
    }
}

struct CountryRow_Previews: PreviewProvider {
    static var previews: some View {
        CountryRow(country: .italy, isFavorite: false) { _ in }
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

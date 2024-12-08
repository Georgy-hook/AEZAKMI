//
//  FlagImage.swift
//  Countries
//
//  Created by Георгий Глухов on 05.12.2024.
//

import CachedAsyncImage
import SwiftUI

struct FlagImage: View {
    let url: URL

    var body: some View {
        CachedAsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Color.secondary
            } else {
                ProgressView()
            }
        }
    }
}

struct CountryFlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(url: Country.italy.flags.png)
    }
}

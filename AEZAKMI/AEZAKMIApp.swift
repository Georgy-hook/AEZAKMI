//
//  AEZAKMIApp.swift
//  AEZAKMI
//
//  Created by Георгий Глухов on 06.12.2024.
//

import SwiftUI

@main
struct AEZAKMIApp: App {
    @StateObject private var countriesViewViewModel: CountriesViewViewModel
    let persistenceController: PersistenceController

    init() {
        let networkingService = NetworkingService()
        self.persistenceController = PersistenceController.shared

        _countriesViewViewModel = StateObject(
            wrappedValue: CountriesViewViewModel(networkingService: networkingService)
        )
    }

    var body: some Scene {
        WindowGroup {
            CountriesView(countriesViewViewModel: countriesViewViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

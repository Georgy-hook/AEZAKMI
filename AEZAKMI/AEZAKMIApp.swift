//
//  AEZAKMIApp.swift
//  AEZAKMI
//
//  Created by Георгий Глухов on 06.12.2024.
//

import SwiftUI

@main
struct AEZAKMIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

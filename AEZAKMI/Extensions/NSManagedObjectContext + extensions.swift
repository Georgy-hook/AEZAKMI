//
//  NSManagedObjectContext + extensions.swift
//  Countries
//
//  Created by Георгий Глухов on 07.12.2024.
//

import CoreData

extension NSManagedObjectContext {
    func saveContext() {
        do {
            try save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

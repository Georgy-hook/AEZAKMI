//
//  CLLocationCoordinate2D+Hashable.swift
//  Countries
//
//  Created by Георгий Глухов on 05.12.2024.
//

import CoreLocation
import Foundation

extension CLLocationCoordinate2D: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
}

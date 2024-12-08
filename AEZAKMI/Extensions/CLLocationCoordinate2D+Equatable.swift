//
//  CLLocationCoordinate2D+Equatable.swift
//  Countries
//
//  Created by Георгий Глухов on 05.12.2024.
//

import CoreLocation
import Foundation

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

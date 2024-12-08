//
//  Country+Span.swift
//  Countries
//
//  Created by Георгий Глухов on 05.12.2024.
//

import Foundation
import MapKit

extension Country {
    var span: MKCoordinateSpan {
        switch area {
        case 0 ... 5000:
            .init(latitudeDelta: 0.5, longitudeDelta: 0.5)
        case 5000 ... 10000:
            .init(latitudeDelta: 0.8, longitudeDelta: 0.8)
        case 10000 ... 50000:
            .init(latitudeDelta: 1, longitudeDelta: 1)
        case 50000 ... 100_000:
            .init(latitudeDelta: 3, longitudeDelta: 4)
        case 100_000 ... 500_000:
            .init(latitudeDelta: 10, longitudeDelta: 10)
        case 500_000 ... 1_000_000:
            .init(latitudeDelta: 15, longitudeDelta: 15)
        case 1_000_000 ... 5_000_000:
            .init(latitudeDelta: 20, longitudeDelta: 20)
        default:
            .init(latitudeDelta: 50, longitudeDelta: 50)
        }
    }
}

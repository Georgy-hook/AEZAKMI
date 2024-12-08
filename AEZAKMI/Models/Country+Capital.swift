//
//  Country+Capital.swift
//  Countries
//
//  Created by Георгий Глухов on 08/12/24.
//

import CoreLocation
import Foundation

extension Country {
    struct Capital: Hashable, Decodable {
        var name: String
        var location: CLLocationCoordinate2D

        init(name: String, location: CLLocationCoordinate2D) {
            self.name = name
            self.location = location
        }

        init(from decoder: Decoder) throws {
            let root = try decoder.container(keyedBy: CodingKeys.self)

            do {
                self.name = try root
                    .decode([String].self, forKey: .name)
                    .first ?? ""
            } catch {
                throw Errors.missingKey("capital")
            }

            do {
                let latlng = try root
                    .nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .location)
                    .decode([CLLocationDegrees].self, forKey: .latlng)

                self.location = .init(latitude: latlng[0], longitude: latlng[1])
            } catch {
                throw Errors.missingKey("capitalInfo-latlng")
            }
        }

        enum CodingKeys: String, CodingKey {
            case name = "capital"
            case location = "capitalInfo"
        }

        enum AdditionalInfoKeys: String, CodingKey {
            case latlng
        }
    }
}

extension Country.Capital: Equatable {
    static func == (lhs: Country.Capital, rhs: Country.Capital) -> Bool {
        lhs.name == rhs.name &&
            lhs.location == rhs.location
    }
}

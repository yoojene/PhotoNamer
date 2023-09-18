//
//  UserLocation.swift
//  PhotoNamer
//
//  Created by Eugene on 18/09/2023.
//

import Foundation
import CoreLocation

struct UserLocation: Identifiable, Codable {
    
    var id: UUID
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = UserLocation(id: UUID(), latitude: 51.501, longitude: -0.141)
}

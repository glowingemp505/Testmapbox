//
//  SharedDataModel.swift
//  testingMapbox
//
//  Created by Sameer Amjad on 13/12/2023.
//

import Foundation
import CoreLocation

struct Trail {
    let name: String
    let coordinates: CLLocationCoordinate2D
    // Add other properties as needed

    // Example initializer if you want to add more properties
    init(name: String, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.coordinates = coordinates
    }
}

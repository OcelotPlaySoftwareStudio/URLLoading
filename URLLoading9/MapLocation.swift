//
//  MapLocation.swift
//  URLLoading9
//  
//  Created by e.hasegawa on 2022/10/11.
//  

import Foundation
import MapKit

struct MapLocation: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    var region: MKCoordinateRegion {
        return MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009))
    }
}

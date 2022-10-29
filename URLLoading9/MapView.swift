//
//  MapView.swift
//  URLLoading9
//  
//  Created by e.hasegawa on 2022/10/11.
//  

import SwiftUI
import MapKit

struct MapView: View {
    let targetLatitude: Double
    let targetLongitude: Double
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.466182, longitude: 139.622062), span: MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009))
    @State var locations: [MapLocation] = []
    
    // MARK: - Views
    
    var body: some View {
        VStack {
            Text(String(targetLatitude))
            Text(String(targetLongitude))
            
            Map(coordinateRegion: $region, annotationItems: locations) { location in
                MapMarker(coordinate: location.coordinate)
            }
            .padding()
        }
        .onAppear {
            setLocation()
        }
    }
    
    func setLocation() {
        let location = MapLocation(latitude: targetLatitude, longitude: targetLongitude)
        region = location.region
        locations.append(location)
    }
}

// MARK: - Previews

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(targetLatitude: 35.466182, targetLongitude: 139.622062)
    }
}

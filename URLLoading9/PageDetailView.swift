//
//  PageDetailView.swift
//  URLLoading9
//  
//  Created by e.hasegawa on 2022/10/11.
//  

import SwiftUI

struct PageDetailView: View {
    var page: Page
    
    // MARK: - Views
    
    var body: some View {
        VStack {
            Text(page.title)
                .font(.title2)
            
            Text(page.description)
                .padding()
            
            MapView(targetLatitude: page.coordinates.first!.lat, targetLongitude: page.coordinates.first!.lon)
        }
    }
}

// MARK: - Previews

struct PageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PageDetailView(page: Page(pageid: 0, title: "横浜駅", terms: nil, coordinates: [Coordinates(lat: 35.466182, lon: 139.622062)]))
    }
}

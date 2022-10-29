//
//  StationItem.swift
//  URLLoading9
//  
//  Created by e.hasegawa on 2022/10/11.
//  

import Foundation

struct StationItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    
    var urlString: String {
        let string = "https://jp.wikipedia.org/w/api.php?ggscoord=\(latitude)%7C\(longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        print(string)
        return string
    }
}

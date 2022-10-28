//
//  StationItem.swift
//  URLLoading5
//  
//  Created by e.hasegawa on 2022/09/12.
//  

import Foundation

struct StationItem {
    let name: String
    let latitude: Double
    let longitude: Double
    
    var urlString: String {
        let string = "https://jp.wikipedia.org/w/api.php?ggscoord=\(latitude)%7C\(longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        print(string)
        return string
    }
}

let stationList = [
    StationItem(name: "横浜", latitude: 35.466182, longitude: 139.622062),
    StationItem(name: "札幌", latitude: 43.068825, longitude: 141.351162),
    StationItem(name: "東京", latitude: 35.681497, longitude: 139.767189),
    StationItem(name: "名古屋", latitude: 35.171092, longitude: 136.881568),
    StationItem(name: "大阪", latitude: 34.702652, longitude: 135.496401),
    StationItem(name: "博多", latitude: 33.589870, longitude: 130.421156)
]

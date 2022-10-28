//
//  UserData.swift
//  URLLoading8
//  
//  Created by e.hasegawa on 2022/10/07.
//  

import Foundation

class UserData: ObservableObject {
    @Published var stationList: [StationItem] = []
    
    static let defaultStationList = [
        StationItem(name: "横浜", latitude: 35.466182, longitude: 139.622062),
        StationItem(name: "札幌", latitude: 43.068825, longitude: 141.351162),
        StationItem(name: "東京", latitude: 35.681497, longitude: 139.767189),
        StationItem(name: "名古屋", latitude: 35.171092, longitude: 136.881568),
        StationItem(name: "大阪", latitude: 34.702652, longitude: 135.496401),
        StationItem(name: "博多", latitude: 33.589870, longitude: 130.421156)
    ]
        
    func saveStationList() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archive = "data.archive"
        let archiveUrl = documentDirectory.appendingPathComponent(archive)
        
        do {
            let jsonData = try JSONEncoder().encode(stationList)
            try jsonData.write(to: archiveUrl)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadStationList() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archive = "data.archive"
        let archiveUrl = documentDirectory.appendingPathComponent(archive)
        
        do {
            let jsonData = try Data(contentsOf: archiveUrl)
            stationList = try JSONDecoder().decode([StationItem].self, from: jsonData)
        } catch {
            print(error.localizedDescription)
        }
        
        if stationList.isEmpty {
            print("No saved station list.")
			stationList = Self.defaultStationList
        } else {
            print(stationList)
        }
    }
}

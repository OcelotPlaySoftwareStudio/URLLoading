//
//  DeleteStationView.swift
//  URLLoading9
//  
//  Created by e.hasegawa on 2022/10/11.
//  

import SwiftUI

struct DeleteStationView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var userData: UserData
    
    // MARK: - Views
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(userData.stationList) { station in
                        Text(station.name)
                    }
                    .onDelete { indexSet in
                        removeStation(indexSet: indexSet)
                        userData.saveStationList()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Close")
                        }
                    }
                }
            }
        }
    }
    
    func removeStation(indexSet: IndexSet) {
        userData.stationList.remove(atOffsets: indexSet)
        print(userData.stationList)
    }
}

// MARK: - Previews

struct DeleteStationView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteStationView(userData: UserData.test())
    }
}

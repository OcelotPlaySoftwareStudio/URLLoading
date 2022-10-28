//
//  DeleteStationView.swift
//  URLLoading8
//  
//  Created by e.hasegawa on 2022/10/07.
//  

import SwiftUI

struct DeleteStationView: View {
    @Binding var isPresented: Bool
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
                            isPresented = false
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
		let data = UserData()
		data.stationList = UserData.defaultStationList
		
        return DeleteStationView(isPresented: .constant(true), userData: data)
    }
}

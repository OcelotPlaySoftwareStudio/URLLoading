//
//  ContentView.swift
//  URLLoading9
//  
//  Created by e.hasegawa on 2022/10/11.
//
// Pull Request Test (2022Nov7)

import SwiftUI

struct ContentView: View {
    @StateObject var userData: UserData = UserData(stationList: [])

    @State var selectedStation = 0
    @State var isShowingPageView = false
    @State var isShowingAddStationView = false
    @State var isShowingDeleteStationView = false
    
    // MARK: - Views
    
    var body: some View {
        VStack {
            Text("Select station")
                .font(.title)
            
            Picker("Station", selection: $selectedStation) {
                ForEach(userData.stationList.indices, id: \.self) { index in
                    Text(userData.stationList[index].name)
                }
            }
            .pickerStyle(.wheel)
            .padding(.bottom)
            
            Button(action: {
                isShowingPageView = true
            }) {
                Text("Tap to show page list")
            }
            .disabled(userData.stationList.isEmpty)
            .sheet(isPresented: $isShowingPageView) {
                PageView(selectedStation: selectedStation, userData: userData, stationChanged: true)
            }
            .padding()
            
            Button(action: {
                isShowingAddStationView = true
            }) {
                Text("Add station")
            }
            .sheet(isPresented: $isShowingAddStationView) {
                AddStationView(userData: userData)
            }
            
            Button(action: {
                isShowingDeleteStationView = true
            }) {
                Text("Delete station")
            }
            .disabled(userData.stationList.isEmpty)
            .sheet(isPresented: $isShowingDeleteStationView) {
                DeleteStationView(userData: userData)
            }
            .padding()
        }
        .onAppear {
            userData.loadStationList()
            
            print(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true))
        }
    }
}

// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(userData: UserData.test())
    }
}

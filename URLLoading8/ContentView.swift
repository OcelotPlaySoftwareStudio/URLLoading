//
//  ContentView.swift
//  URLLoading8
//  
//  Created by e.hasegawa on 2022/10/07.
//  

import SwiftUI

struct ContentView: View {
    @StateObject var userData: UserData = UserData()

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
                PageView(selectedStation: selectedStation, isPresented: $isShowingPageView, userData: userData, stationChanged: true)
            }
            .padding()
            
            Button(action: {
                isShowingAddStationView = true
            }) {
                Text("Add station")
            }
            .sheet(isPresented: $isShowingAddStationView) {
                AddStationView(isPresented: $isShowingAddStationView, userData: userData)
            }
            
            Button(action: {
                isShowingDeleteStationView = true
            }) {
                Text("Delete station")
            }
            .disabled(userData.stationList.isEmpty)
            .sheet(isPresented: $isShowingDeleteStationView) {
                DeleteStationView(isPresented: $isShowingDeleteStationView, userData: userData)
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
        ContentView()
    }
}

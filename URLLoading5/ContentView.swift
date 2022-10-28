//
//  ContentView.swift
//  URLLoading5
//  
//  Created by e.hasegawa on 2022/09/12.
//  

import SwiftUI

struct ContentView: View {
    @State var selectedStation = 0
    @State var isShowingPageView = false
    
    // MARK: - Views
    
    var body: some View {
        VStack {
            Text("Select station")
                .font(.title)
            
            Picker("Station", selection: $selectedStation) {
                ForEach(0..<stationList.count, id: \.self) { index in
                    Text(stationList[index].name)
                }
            }
            .pickerStyle(.wheel)
            .padding(.bottom)
            
            Button(action: {
                isShowingPageView = true
            }) {
                Text("Tap to show page list")
                    .padding()
            }
            .sheet(isPresented: $isShowingPageView) {
                PageView(selectedStation: selectedStation, isPresented: $isShowingPageView, stationChanged: true)
            }
        }
    }
}

// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

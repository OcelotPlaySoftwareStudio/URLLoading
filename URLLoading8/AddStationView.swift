//
//  AddStationView.swift
//  URLLoading8
//  
//  Created by e.hasegawa on 2022/10/07.
//  

import SwiftUI
import MapKit

struct AddStationView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool
    @ObservedObject var userData: UserData
    
    @State var stationName = ""
    @State var latitude: Double?
    @State var longitude: Double?
    
    // MARK: - Views
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Station name", text: $stationName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        getCoordinate()
                    }) {
                        Text("Search")
                            .padding()
                    }
                    .disabled(stationName.isEmpty)
                }
                
                TextField("Latitude", value: $latitude, format: .number)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Longitude", value: $longitude, format: .number)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    appendStation()
                    userData.saveStationList()
                    dismiss()
                }) {
                    Text("Save")
                        .padding()
                }
                .disabled(stationName.isEmpty || latitude == nil || longitude == nil)
                .padding()
            }
            .toolbar {
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
    
    func getCoordinate() {
        let searchKey = stationName
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchKey,
                                      completionHandler: { (placemarks, error) in
            if let unwrappedPlacemarks = placemarks,
               let firstPlacemark = unwrappedPlacemarks.first,
               let location = firstPlacemark.location {
                latitude = location.coordinate.latitude
                longitude = location.coordinate.longitude
            }
        })
    }
    
    func appendStation() {
        guard let latitudeDouble = latitude, let longitudeDouble = longitude else {
            return
        }
        userData.stationList.append(StationItem(name: stationName, latitude: latitudeDouble, longitude: longitudeDouble))
        print(userData.stationList)
    }
}

// MARK: - Previews

struct AddStationView_Previews: PreviewProvider {
    static var previews: some View {
        AddStationView(isPresented: .constant(true), userData: UserData())
    }
}

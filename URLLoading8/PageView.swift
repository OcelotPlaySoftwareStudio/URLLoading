//
//  PageView.swift
//  URLLoading8
//  
//  Created by e.hasegawa on 2022/10/07.
//  

import SwiftUI

struct PageView: View {
	@Environment(\.dismiss) var dismiss
	
	var station: StationItem
    
    @State var stationChanged: Bool
    @State var urlString = ""
    @State var textData = "Loading..."
    @State var pages = [Page]()
    
    // MARK: - Views
    
    var body: some View {
        NavigationView {
            List {
                ForEach(pages, id: \.pageid) { page in
                    NavigationLink(destination: PageDetailView(page: page)) {
                        Text(page.title)
                    }
                }
            }
            .onAppear {
                if stationChanged {
                    urlString = station.urlString
					Task {
                        await search()
                    }
                    stationChanged = false
                }
            }
            .navigationTitle("Page List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Close")
                    }
                }
            }
        }
        .padding(.bottom)
    }
    
    
    // MARK: - URL Loading Methods
    
    func search() async {
        let url = URL(string: urlString)!
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            textData = String(data: data, encoding: .utf8)!
            
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            let items = DataConverter.itemsFromJSON(data)
            if !items.isEmpty {
                print("\(items.count) pages found!")
                pages = items
            } else {
                print("Pages not found...")
            }
            
        } catch {
            textData = "Error..."
        }
    }
}

// MARK: - Previews

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
		let data = UserData()
		data.stationList = UserData.defaultStationList

		return PageView(station: UserData.defaultStationList[0], stationChanged: true)
    }
}

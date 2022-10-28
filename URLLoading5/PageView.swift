//
//  PageView.swift
//  URLLoading5
//  
//  Created by e.hasegawa on 2022/09/12.
//  

import SwiftUI

struct PageView: View {
    let selectedStation: Int
    @Binding var isPresented: Bool
    @State var stationChanged: Bool
    @State var urlString = ""
    @State var textData = "Loading..."
    @State var pages = [Page]()

	@Environment(\.dismiss) var dismiss
	
	
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
                    urlString = stationList[selectedStation].urlString
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
//                        isPresented = false
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
			print("⭐️")
			print(textData)
            
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

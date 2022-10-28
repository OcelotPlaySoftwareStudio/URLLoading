//
//  PageView.swift
//  URLLoading8
//  
//  Created by e.hasegawa on 2022/10/07.
//  

import SwiftUI

struct PageView: View {
    let selectedStation: Int
    @Binding var isPresented: Bool
    @ObservedObject var userData: UserData
    
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
                    urlString = userData.stationList[selectedStation].urlString // エラー（Fatal error: Index out of range）が出る時がある
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
                        isPresented = false
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
        PageView(selectedStation: 0, isPresented: .constant(true), userData: UserData(), stationChanged: true)
    }
}

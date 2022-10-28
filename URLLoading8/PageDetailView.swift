//
//  PageDetailView.swift
//  URLLoading8
//  
//  Created by e.hasegawa on 2022/10/07.
//  

import SwiftUI

struct PageDetailView: View {
    var page: Page
    
    // MARK: - Views
    
    var body: some View {
        VStack {
            Text(page.title)
                .font(.title2)
                .padding()
            Text(page.description)
            Spacer()
        }
    }
}

// MARK: - Previews

struct PageDetailView_Previews: PreviewProvider {
    static var previews: some View {
            PageDetailView(page: Page(pageid: 0, title: "横浜駅", terms: nil))
    }
}

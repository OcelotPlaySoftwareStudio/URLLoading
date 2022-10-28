//
//  PageDetailView.swift
//  URLLoading5
//  
//  Created by e.hasegawa on 2022/09/12.
//  

import SwiftUI

struct PageDetailView: View {
    let page: Page
    
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

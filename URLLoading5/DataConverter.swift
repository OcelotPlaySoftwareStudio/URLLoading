//
//  DataConverter.swift
//  URLLoading5
//  
//  Created by e.hasegawa on 2022/09/12.
//  

import Foundation

class DataConverter {
    
    static func itemsFromJSON(_ json: Data) -> [Page] {
        do {
            let result = try JSONDecoder().decode(Result.self, from: json)
            return result.query.pages.values.sorted()
            
        } catch {
            print((error))
        }
        return []
    }
    
}

// MARK: - Struct for Wikipedia API's Result

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
	    
    var description: String {
        terms?["description"]?.first ?? "No further info..."
    }
	
    static func <(lhs: Page, rhs: Page) -> Bool {
        return lhs.title < rhs.title
    }
 }

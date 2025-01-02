//
//  ReviewResults.swift
//  AppStore
//
//  Created by Baris Karalar on 26.12.24.
//

import Foundation

struct ReviewResults: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let entry: [Review]
}

struct Review: Codable, Identifiable {
    var id: String { content.label }
    let content: JSONLabel
    let title: JSONLabel
    let author: Author
    let rating: JSONLabel
    
    enum CodingKeys: String, CodingKey {
        case content
        case title
        case author
        case rating = "im:rating"
    }
}

struct Author: Codable {
    let name: JSONLabel
}

struct JSONLabel: Codable {
    let label: String
}

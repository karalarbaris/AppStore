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
    let content: Content
}

struct Content: Codable {
    let label: String
}

//
//  SearchResult.swift
//  AppStore
//
//  Created by Baris Karalar on 04.10.24.
//

struct SearchResult: Codable {
    let results: [Result]
}

struct Result: Codable, Identifiable {
    
    var id: Int { trackId }
    let trackId: Int
    let trackName: String
    let artworkUrl512: String
    let primaryGenreName: String
    let screenshotUrls: [String]
    let averageUserRating: Double
    let userRatingCount: Int
}

//
//  AppDetail.swift
//  AppStore
//
//  Created by Baris Karalar on 23.10.24.
//

import Foundation

struct AppDetailResults: Codable {
    let resultCount: Int
    let results: [AppDetail]
}

struct AppDetail: Codable {
    let artistName: String
    let trackName: String
    let releaseNotes: String
    let description: String
    let screenshotUrls: [String]
    let artworkUrl512: String
    let version: String
}

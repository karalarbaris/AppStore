//
//  APIService.swift
//  AppStore
//
//  Created by Baris Karalar on 06.01.25.
//

import Foundation

struct APIService {
    
    enum APIError: Error {
        case appDetailNotFound
        case badResponse(statusCode: Int)
        case badURL
    }
    
    static func fetchSearchResults(searchValue: String) async throws -> [Result] {
        let searchResult: SearchResult = try await decode(urlString: "https://itunes.apple.com/search?term=\(searchValue)&entity=software")
        return searchResult.results
    }
    
    static func fetchAppDetail(trackId: Int) async throws -> AppDetail {
        let appDetailResult: AppDetailResults = try await decode(urlString: "https://itunes.apple.com/lookup?id=\(trackId)")
        if let appDetail = appDetailResult.results.first {
            return appDetail
        }
        throw APIError.appDetailNotFound
    }
    
    static func fetchReviews(trackId: Int) async throws -> [Review] {
        let results: ReviewResults = try await decode(urlString: "https://itunes.apple.com/rss/customerreviews/page=1/id=\(trackId)/sortby=mostrecent/json?l=en&cc=us")
        return results.feed.entry
    }
    
    static private func decode<T: Codable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIError.badURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let statusCode = (response as? HTTPURLResponse)?.statusCode, !(statusCode >= 200 && statusCode < 300) {
            throw APIError.badResponse(statusCode: statusCode)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
}

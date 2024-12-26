//
//  ReviewsViewModel.swift
//  AppStore
//
//  Created by Baris Karalar on 26.12.24.
//

import Foundation

@MainActor
class ReviewsViewModel: ObservableObject {
    
    @Published var reviews: [Review] = []
    private let trackId: Int
    
    init (trackId: Int) {
        self.trackId = trackId
        fetchReviews()
    }
    
    private func fetchReviews () {
        
        Task {
            do {
                guard let url = URL(string: "https://itunes.apple.com/rss/customerreviews/page=1/id=\(trackId)/sortby=mostrecent/json?l=en&cc=us") else { return }
                let (data, response) = try await URLSession.shared.data(from: url)
                let results = try JSONDecoder().decode(ReviewResults.self, from: data)
                self.reviews = results.feed.entry
                
            } catch {
                print("Failed to fetch reviews: \(error.localizedDescription)")
            }
        }
        
    }
}

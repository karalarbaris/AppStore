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
    @Published var error: Error?
    
    private let trackId: Int
    
    init (trackId: Int) {
        self.trackId = trackId
        getReviews()
    }
    
    private func getReviews () {
        
        Task {
            do {
                self.reviews = try await APIService.fetchReviews(trackId: trackId)
                
            } catch {
                print("Failed to fetch reviews: \(error.localizedDescription)")
                self.error = error
            }
        }
        
    }
}

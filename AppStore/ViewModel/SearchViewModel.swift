//
//  SearchViewModel.swift
//  AppStore
//
//  Created by Baris Karalar on 04.10.24.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    
    @Published var results: [Result] = []
    
    init() {
        fetchJSONData()
    }
    
    
    private func fetchJSONData() {
        
        Task {
            
            do {
                guard let url = URL(string: "https://itunes.apple.com/search?term=youtube&entity=software") else  { return }
                let (data, response) = try await URLSession.shared.data(from: url)
                
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
//                searchResult.results.forEach { result in
//                    print(result.trackName)
//                }
                results = searchResult.results
            } catch {
                print("Error: \(error)")
            }
            
        }
        
    }
}

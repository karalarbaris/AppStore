//
//  SearchViewModel.swift
//  AppStore
//
//  Created by Baris Karalar on 04.10.24.
//

import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    
    @Published var results: [Result] = []
    @Published var query = "you"
    @Published var isSearching: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
        $query
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] newValue in
            self?.fetchJSONData(searchValue: newValue)
        }.store(in: &cancellables)
        
    }
    
    
    private func fetchJSONData(searchValue: String) {
        
        Task {
            
            do {
                guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchValue)&entity=software") else  { return }
                isSearching = true
                let (data, response) = try await URLSession.shared.data(from: url)
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
//                searchResult.results.forEach { result in
//                    print(result.trackName)
//                }
                results = searchResult.results
                isSearching = false
            } catch {
                print("Error: \(error)")
                isSearching = false
            }
            
        }
        
    }
}

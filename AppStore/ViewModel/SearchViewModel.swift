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
    @Published var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $query
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] newValue in
            self?.getSearchResults(searchValue: newValue)
        }.store(in: &cancellables)
    }
    
    
    private func getSearchResults(searchValue: String) {
        Task {
            do {
                isSearching = true
                results = try await APIService.fetchSearchResults(searchValue: searchValue)
                isSearching = false
            } catch {
                print("Error: \(error)")
                self.error = error
                isSearching = false
            }
        }
    }
    
}

//
//  SearchDetailViewModel.swift
//  AppStore
//
//  Created by Baris Karalar on 23.10.24.
//

import Foundation

@MainActor
class AppDetailViewModel: ObservableObject {
    
    @Published var appDetail: AppDetail?
    let trackId: Int
    
    init(trackId: Int) {
        self.trackId = trackId
        getAppDetail(trackId: trackId)
    }
    
    
    private func getAppDetail(trackId: Int) {
        Task {
            
            do {
                guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(trackId)") else { return }
                let (data, response) = try await URLSession.shared.data(from: url)
                let appDetailResult = try JSONDecoder().decode(AppDetailResults.self, from: data)
                self.appDetail = appDetailResult.results.first
            } catch {
                print("Error: \(error)")
            }
            
        }
    }
    
    
}

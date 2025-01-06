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
    @Published var error: Error?
    
    let trackId: Int
    
    init(trackId: Int) {
        self.trackId = trackId
        getAppDetail(trackId: trackId)
    }
    
    
    private func getAppDetail(trackId: Int) {
        Task {
            do {
                self.appDetail = try await APIService.fetchAppDetail(trackId: trackId)
            } catch {
                print("Error: \(error)")
                self.error = error
            }
        }
    }
    
}

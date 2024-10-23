//
//  SearchDetailView.swift
//  AppStore
//
//  Created by Baris Karalar on 23.10.24.
//

import SwiftUI

struct AppDetailView: View {
    
    @StateObject var vm: AppDetailViewModel
    let trackId: Int
    
    init(trackId: Int) {
        self.trackId = trackId
        self._vm = .init(wrappedValue: AppDetailViewModel(trackId: trackId))
    }
    
    var body: some View {
        ScrollView {
            if let appDetail = vm.appDetail {
                HStack(spacing: 16) {
                    
                    AsyncImage(url: URL(string: appDetail.artworkUrl512)) { img in
                        img
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 100, height: 100)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(appDetail.trackName)
                            .font(.system(size: 24, weight: .semibold))
                        Text(appDetail.artistName)
                        Image(systemName: "icloud.and.arrow.down")
                            .font(.system(size: 24))
                            .padding(.top, 4)
                    }
                    Spacer()
                    
                }
                .padding()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("What's New")
                            .font(.system(size: 24, weight: .semibold))
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("Version History")
                        }
                        
                    }
                    Text("Version: \(appDetail.version)")
                        .font(.callout)
                        .fontWeight(.light)
                    Text(appDetail.releaseNotes)
                        .padding(.top, 4)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.system(size: 24, weight: .semibold))
                        .padding(.vertical)
                    
                    Text(appDetail.description)
                }
                .padding(.horizontal)
                
                
            }
            
        }
        //        .navigationTitle("deneme")
    }
}

#Preview {
    NavigationStack {
        AppDetailView(trackId: 544007664)
            .preferredColorScheme(.dark)
    }
}

//
//  ContentView.swift
//  AppStore
//
//  Created by Baris Karalar on 26.09.24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var vm = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                if vm.isSearching {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .controlSize(.large)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                ZStack {
                    if vm.results.isEmpty && vm.query.isEmpty {
                        VStack(spacing:16) {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .font(.system(size: 50))
                            Text("Please search for results")
                                .font(.title)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ScrollView {
                            ForEach(vm.results) { result in
                                
                                NavigationLink {
                                    AppDetailView(trackId: result.trackId)
                                } label: {
                                    VStack(spacing: 16) {
                                        AppIconTitleView(result: result)
                                        
                                        ScreenshotsRow(proxy: proxy, result: result)
                                    }
                                    .padding(16)
                                    
                                }
                                
                                
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $vm.query)
        }
    }
}

#Preview {
    SearchView()
        .preferredColorScheme(.dark)
}

struct AppIconTitleView: View {
    
    let result: Result
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: result.artworkUrl512)) { img in
                img
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } placeholder: {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 80, height: 80)
            }
            
            VStack(alignment: .leading) {
                Text(result.trackName)
                    .lineLimit(1)
                    .font(.system(size: 20))
                Text(result.primaryGenreName)
                    .foregroundStyle(.gray)
                
                HStack(spacing: 1) {
                    ForEach(0..<Int(result.averageUserRating), id: \.self) {_ in
                        Image(systemName: "star.fill")
                    }
                    ForEach(0..<5-Int(result.averageUserRating), id: \.self) {_ in
                        Image(systemName: "star")
                    }
                    Text(result.userRatingCount.roundedWithAbbreviations)
                        .padding(.leading, 4)
                        .font(.headline)
                }
                .padding(.top, 1)
            }
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "icloud.and.arrow.down")
                    .font(.system(size: 24))
            }
            
        }
    }
}

struct ScreenshotsRow: View {
    
    let proxy: GeometryProxy
    let result: Result
    
    var body: some View {
        let width = (proxy.size.width - 4 * 16) / 3
        HStack(spacing: 16) {
            
            ForEach(result.screenshotUrls.prefix(3), id: \.self) { url in
                AsyncImage(url: URL(string: url)) { img in
                    img
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: width, height: 200)
                }
            }
        }
    }
}

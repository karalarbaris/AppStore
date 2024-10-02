//
//  ContentView.swift
//  AppStore
//
//  Created by Baris Karalar on 26.09.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ScrollView {
                    ForEach(0..<10) { num in
                        VStack(spacing: 16) {
                            AppIconTitleView()
                            
                            ScreenshotsRow(proxy: proxy)
                        }
                    }
                    .padding(16)
                }
            }
            .navigationTitle("Search")
            .searchable(text: .constant("Enter search term"))
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}

struct ScreenshotsRow: View {
    
    let proxy: GeometryProxy
    
    var body: some View {
        let width = (proxy.size.width - 4 * 16) / 3
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: width, height: 200)
            RoundedRectangle(cornerRadius: 16)
                .frame(width: width, height: 200)
            RoundedRectangle(cornerRadius: 16)
                .frame(width: width, height: 200)
        }
    }
}

struct AppIconTitleView: View {
    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 80, height: 80)
            VStack(alignment: .leading) {
                Text("Youtube: Watch listen etc etc etc")
                    .lineLimit(1)
                    .font(.system(size: 20))
                Text("Photo & Video")
                    .foregroundStyle(.gray)
                Text("Stars 30.0M")
            }
            Image(systemName: "icloud.and.arrow.down")
        }
    }
}

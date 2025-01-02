//
//  ReviewsView.swift
//  AppStore
//
//  Created by Baris Karalar on 26.12.24.
//

import SwiftUI

struct ReviewsView: View {
    
    @StateObject var vm: ReviewsViewModel
    private let proxy: GeometryProxy
    
    init(trackId: Int, proxy: GeometryProxy) {
        self._vm = .init(wrappedValue: .init(trackId: trackId))
        self.proxy = proxy
    }
    
    var body: some View {
        
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(vm.reviews) { review in
                        
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text(review.title.label)
                                    .lineLimit(1)
                                    .font(.system(size: 20, weight: .semibold))
                                Spacer()
                                Text(review.author.name.label)
                                    .lineLimit(1)
                                    .foregroundStyle(Color(.lightGray))
                            }
                            HStack {
                                if let rating = Int(review.rating.label) {
                                    ForEach(0..<rating) { num in
                                        Image(systemName: "star.fill")
                                            .foregroundStyle(Color(.yellow))
                                    }
                                    ForEach(0..<5-rating) { num in
                                        Image(systemName: "star")
                                            .foregroundStyle(Color(.yellow))
                                    }
                                }
                            }
                            Text(review.content.label)
                            Spacer()
                        }
                        .padding()
                        .frame(width: proxy.size.width - 64, height: 200)
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding(.horizontal)
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
        
    }
}

#Preview {
    GeometryReader { proxy in
        ReviewsView(trackId: 544007664, proxy: proxy)
            .preferredColorScheme(.dark)
    }
}

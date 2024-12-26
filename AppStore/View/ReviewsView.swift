//
//  ReviewsView.swift
//  AppStore
//
//  Created by Baris Karalar on 26.12.24.
//

import SwiftUI

struct ReviewsView: View {
    
    @StateObject var vm: ReviewsViewModel
    
    init(trackId: Int) {
        self._vm = .init(wrappedValue: .init(trackId: trackId))
    }
    
    var body: some View {
        
        GeometryReader { proxy in
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(vm.reviews) { review in
                        
                        VStack {
                            Text(review.content.label)
                        }
                        .padding()
                        .frame(width: proxy.size.width - 64, height: 200)
                        .background(Color(.init(white: 1, alpha: 0.15)))
                    }
                }
                .padding()
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }
}

#Preview {
    ReviewsView(trackId: 544007664)
        .preferredColorScheme(.dark)
}

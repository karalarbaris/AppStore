//
//  FullScreeenScreenshotsView.swift
//  AppStore
//
//  Created by Baris Karalar on 25.10.24.
//

import SwiftUI

struct FullScreeenScreenshotsView: View {
    
    let screenShotsUrls: [String]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color(.label))
                            .font(.title)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        let width = proxy.size.width - 64
                        ForEach(screenShotsUrls, id: \.self) { url in
                            AsyncImage(url: URL(string: url)) { img in
                                img
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: width, height: 600)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            } placeholder: {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .controlSize(.large)
                                    .frame(width: width, height: 600)
    //                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                        }
                    }
                    .padding(.horizontal, 32)
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
            }
        }
    }
}

#Preview {
    FullScreeenScreenshotsView(screenShotsUrls: [
        "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/25/84/db/2584db5e-1b7d-197f-1a33-13602daf5d95/f1192f1f-430d-469a-b032-cdf77b8b04c7_iOS-5.5-in_1.jpg/392x696bb.jpg",
        "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/54/0a/8d/540a8daf-4cc2-397a-e1b1-90b859947b44/868afd15-b2e4-4923-b0f8-c5599327a3d7_iOS-5.5-in_2.jpg/392x696bb.jpg",
        "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/a1/e3/e8/a1e3e81c-94e1-9bc2-c5f6-f5efe2814230/2930dbc3-4228-403b-b46d-e0066516ab6a_iOS-5.5-in_3.jpg/392x696bb.jpg",
        "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/9e/cd/9b/9ecd9b66-ade4-70f8-a6f6-7b1ee3cc7b41/45519fca-0e0b-466e-9ed6-9a43232a0bf8_iOS-5.5-in_4.jpg/392x696bb.jpg",
        "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/90/e2/4b/90e24bd5-b81b-558a-3b1a-e5acf46a7669/bace9abd-71f3-4700-8adf-cedcba275a67_iOS-5.5-in_5.jpg/392x696bb.jpg"])
    .preferredColorScheme(.dark)
}

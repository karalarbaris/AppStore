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
        GeometryReader { proxy in
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
                
                PreviewScreenshotsView(vm: vm)
                
                VStack(alignment: .leading) {
                    Text("Reviews")
                        .font(.system(size: 24, weight: .semibold))
                        .padding(.vertical)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
 
                ReviewsView(trackId: vm.trackId, proxy: proxy)
                
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.system(size: 24, weight: .semibold))
                        .padding(.vertical)
                    
                    Text(appDetail.description)
                }
                .padding(.horizontal)
                
                
            }
            
        }
        }
            //        .navigationTitle("deneme")
    }
}


struct PreviewScreenshotsView: View {
    
    @StateObject var vm: AppDetailViewModel
    @State var isPresentingPreviews: Bool = false
    
    var body: some View {
        Text("Preview")
            .font(.system(size: 24, weight: .semibold))
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        
        ScrollView(.horizontal) {
                HStack(spacing:16) {
                    ForEach(vm.appDetail?.screenshotUrls ?? [], id: \.self) { screenshotUrl in
                        Button {
                            isPresentingPreviews.toggle()
                        } label: {
                            AsyncImage(url: URL(string: screenshotUrl)) { img in
                                img
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 220, height: 400)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            } placeholder: {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .controlSize(.large)
//                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .frame(width: 220, height: 400)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .foregroundStyle(Color(.label))
                .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .fullScreenCover(isPresented: $isPresentingPreviews) {
            FullScreeenScreenshotsView(screenShotsUrls: vm.appDetail?.screenshotUrls ?? [])
        }
    }
}





#Preview {
    NavigationStack {
        AppDetailView(trackId: 544007664)
            .preferredColorScheme(.dark)
    }
}

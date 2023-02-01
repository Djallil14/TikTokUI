//
//  ContentView.swift
//  TikTokUI
//
//  Created by Djallil on 2023-01-27.
//

import SwiftUI
import AVKit

struct HomeView: View {
    @State var selectedTab: TabBarItems = .home
    @State var selectedCategory: Category = .foryou
    @State var videos = Video.sample
    @State var videoIndex = 0
    @State var videoHeight: CGFloat = .zero
    @State var currentVideo: Video = Video.sample.first!
    @State var heightPlayerOffset: CGFloat = 0
    @State var playerDismissalOffset: CGFloat = 0
    @State var currentPlayer: AVQueuePlayer?
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Color.white
                    .onAppear {
                        videoHeight = proxy.frame(in: .local).height
                    }
            }
            Color.black.edgesIgnoringSafeArea(.top)
            VStack(spacing: 0) {
                ZStack {
                ForEach(videos) { video in
                        videoPlayerFor(video: video, currentVideoPlayer: video == currentVideo)
                            .edgesIgnoringSafeArea(.top)
                            .offset(y: video == currentVideo ? heightPlayerOffset : playerDismissalOffset)
                            .opacity(video == currentVideo ? 1 : 0)
                            .zIndex(video == currentVideo ? -1 : -99)
                            .gesture(DragGesture(minimumDistance: 50, coordinateSpace: .global)
                                .onChanged({handleDragGestureChange($0)})
                                .onEnded({handleEndDragGesture($0)}))
                    }
                }.frame(height: videoHeight)
                
                TikTokTabBarView(selectedTab: $selectedTab)
                    .frame(height: 60)
                    .padding(.bottom)
            }
        }
    }
    
    private func handleEndDragGesture(_ value: DragGesture.Value) {
        let horizontalAmount = value.translation.width
        let verticalAmount = value.translation.height
        
        if abs(horizontalAmount) > abs(verticalAmount) {
            return
        } else {
            if verticalAmount > 200 {
                // Previous Video
                guard videoIndex > 0 else {
                    heightPlayerOffset = 0
                    return
                }
                withAnimation(.easeInOut(duration: 0.5)) {
                    playerDismissalOffset = 1000
                    heightPlayerOffset = 0
                    videoIndex -= 1
                    currentVideo = videos[videoIndex]
                    currentPlayer?.play()
                }
            } else if verticalAmount < 200 {
                guard videoIndex < videos.count - 1 else {
                    heightPlayerOffset = 0
                    return
                }
                // Next Video
                withAnimation(.easeInOut(duration: 0.5)) {
                    playerDismissalOffset = -1000
                    heightPlayerOffset = 0
                    videoIndex += 1
                    currentVideo = videos[videoIndex]
                    currentPlayer?.play()
                }
            }
        }
    }
    
    private func handleDragGestureChange(_ value: DragGesture.Value) {
        let horizontalAmount = value.translation.width
        let verticalAmount = value.translation.height
        
        if abs(horizontalAmount) > abs(verticalAmount) {
            // Horizontal Swipe
            return
        } else {
            // Vertical Swipe
            withAnimation(.easeInOut(duration: 0.5)) {
                self.heightPlayerOffset = verticalAmount
            }
        }
    }
    
    @ViewBuilder
    private func videoPlayerFor(video: Video,  currentVideoPlayer: Bool) -> some View {
        if video == currentVideo {
            let player = AVQueuePlayer(url: video.url!)
            CustomVideoPlayer(player: player)
                .overlay {
                    VideoPlayerOverlayView(selectedCategory: $selectedCategory, video: $currentVideo)
                }
                .onAppear {
                    if currentVideoPlayer {
                        player.externalPlaybackVideoGravity = .resizeAspectFill
                        currentPlayer = player
                        player.isMuted = true
                        player.play()
                    } else {
                        player.pause()
                    }
                }
                .onDisappear {
                    currentPlayer = nil
                    player.pause()
                    player.removeAllItems()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

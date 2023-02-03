//
//  HomeViewModel.swift
//  TikTokUI
//
//  Created by Djallil on 2023-02-01.
//

import SwiftUI
import AVKit

class HomeViewModel: ObservableObject {
    @Published var videos = Video.sample
    @Published var videoIndex = 0
    @Published var currentVideo: Video = Video.sample.first!
    @Published var heightPlayerOffset: CGFloat = 0
    @Published var playerDismissalOffset: CGFloat = 0
    @Published var currentPlayer: AVQueuePlayer?
    
    func handleEndDragGesture(_ value: DragGesture.Value) {
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
                withAnimation(.easeInOut(duration: 0.3)) {
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
                withAnimation(.easeInOut(duration: 0.3)) {
                    playerDismissalOffset = -1000
                    heightPlayerOffset = 0
                    videoIndex += 1
                    currentVideo = videos[videoIndex]
                    currentPlayer?.play()
                }
            }
        }
    }
    
    func handleDragGestureChange(_ value: DragGesture.Value) {
        let horizontalAmount = value.translation.width
        let verticalAmount = value.translation.height
        
        if abs(horizontalAmount) > abs(verticalAmount) {
            // Horizontal Swipe
            return
        } else {
            // Vertical Swipe
            withAnimation(.easeInOut(duration: 0.3)) {
                self.heightPlayerOffset = verticalAmount
            }
        }
    }
    
    func isCurrentVideo(_ video: Video) -> Bool {
        video == currentVideo
    }
}

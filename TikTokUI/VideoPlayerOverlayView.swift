//
//  VideoPlayerOverlayView.swift
//  TikTokUI
//
//  Created by Djallil on 2023-01-30.
//

import SwiftUI
import AVKit

struct VideoPlayerOverlayView: View {
    @Binding var selectedCategory: Category
    @Binding var video: Video
    var body: some View {
        VStack {
            TikTokCustomPicker(selectedCategory: $selectedCategory)
                .foregroundColor(.white)
                .padding(.top, 44)
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    Text(video.userName)
                        .foregroundColor(.white)
                        .font(.headline)
                    Text(video.videoDescription)
                        .foregroundColor(.white)
                        .font(.callout)
                    HStack {
                        ForEach(video.hashtags, id: \.self) { hashtag in
                            Text(hashtag)
                                .bold()
                                .foregroundColor(.white)
                                .font(.caption)
                        }
                    }
                }
                .padding(8)
                Spacer()
                VStack(spacing: 20) {
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 44, height: 44)
                            .clipShape(Circle())
                        Image(video.userImageString)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    }
                    ForEach(OverlayVideoButtons.allCases, id:\.self) { button in
                        Button(action:{}) {
                            VStack {
                                Image(systemName: button.icon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 34, height: 34)
                                .foregroundColor(.white)
                                switch button {
                                case .like:
                                    Text("\(video.likes)")
                                        .bold()
                                        .font(.callout)
                                        .foregroundColor(.white)
                                case .share:
                                    Text("\(video.shares)")
                                        .bold()
                                        .font(.callout)
                                        .foregroundColor(.white)
                                case .comments:
                                    Text("\(video.comments)")
                                        .bold()
                                        .font(.callout)
                                        .foregroundColor(.white)
                                case .bookmarked:
                                    Text("\(video.bookmarked)")
                                        .bold()
                                        .font(.callout)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(8)
            }
            HStack {
                HStack(spacing: 0) {
                    Image(systemName: "music.note")
                        .foregroundColor(.white)
                    Text(": \(video.musicName)")
                        .foregroundColor(.white)
                    Spacer()
                    RotatingProfilImageView(imageName: "eminem")
                }
                .padding(.horizontal, 8)
                .padding(.bottom)
            }
        }
    }
}

struct VideoPlayerOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayer(player: .init()) {
            VideoPlayerOverlayView(selectedCategory: .constant(.foryou), video: .constant(Video.sample.first!))
        }
    }
}

struct RotatingProfilImageView: View {
    @State var rotation: CGFloat = 0
    let imageName: String
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 44, height: 44)
                .clipShape(Circle())
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .rotationEffect(.degrees(rotation))
        }
        .onReceive(timer, perform: { timer in
            withAnimation(.linear(duration: 1)) {
                rotation += 180
            }
        })
        .onDisappear {
            timer.upstream.connect().cancel()
        }
    }
}

enum OverlayVideoButtons: String, CaseIterable {
    case like
    case comments
    case bookmarked
    case share
    
    var icon: String {
        switch self {
        case .like:
            return "heart.fill"
        case .comments:
            return "ellipsis.message.fill"
        case .bookmarked:
            return "bookmark.fill"
        case .share:
            return "arrowshape.turn.up.right.fill"
        }
    }
    
    var text: String {
        switch self {
        case .like:
            return "336.9k"
        case .comments:
            return "5950"
        case .bookmarked:
            return "41.3k"
        case .share:
            return "37.2K"
        }
    }
}

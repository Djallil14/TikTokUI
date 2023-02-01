//
//  TikTokVideoModel.swift
//  TikTokUI
//
//  Created by Djallil on 2023-01-30.
//

import Foundation

struct Video: Identifiable, Equatable {
    let id: UUID
    let userName: String
    let userImageString = "userProfil"
    let videoDescription: String
    let hashtags: [String]
    let urlString: String
    var url: URL? {
        URL(string: urlString)
    }
    let musicName = "EMINEM - Lose your self"
    
    let likes = Int.random(in: 0...3000)
    let comments = Int.random(in: 0...3000)
    let bookmarked = Int.random(in: 0...3000)
    let shares = Int.random(in: 0...3000)
}

extension Video {
    static let sample: [Video] = [
        .init(id: UUID(),
              userName: "Big Buck Bunny",
              videoDescription: "Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself. When one sunny day three rodents rudely harass him, something snaps... and the rabbit ain't no bunny anymore! In the typical cartoon tradition he prepares the nasty rodents a comical revenge.\n\nLicensed under the Creative Commons Attribution license\nhttp://www.bigbuckbunny.org",
              hashtags: ["#likeplease", "#andsubscribe", "#thank you"],
              urlString: "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"),
        .init(id: UUID(),
              userName: "Blender",
              videoDescription: "The first Blender Open Movie from 2006",
              hashtags: ["#it", "#would", "#help", "#alot"],
              urlString: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),
        .init(id: UUID(),
              userName: "Sintel",
              videoDescription: "Sintel is an independently produced short film, initiated by the Blender Foundation as a means to further improve and validate the free/open source 3D creation suite Blender.",
              hashtags: ["#it", "#would", "#help", "#alot"],
              urlString: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4")
    ]
}



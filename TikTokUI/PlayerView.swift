import SwiftUI
import AVKit
import AVFoundation

class PlayerView: UIView {

    // Override the property to make AVPlayerLayer the view's backing layer.
    override static var layerClass: AnyClass { AVPlayerLayer.self }
    
    // The associated player object.
    var player: AVPlayer? {
        get {
            playerLayer.player
        }
        set {
            playerLayer.player = newValue
            playerLayer.player?.play()
        }
    }
    
    var queuePlayer: AVQueuePlayer? {
        didSet {
            let item = AVPlayerItem(url: urlOfCurrentlyPlayingInPlayer(player: queuePlayer!))
            playerLooper = AVPlayerLooper(player: queuePlayer!, templateItem: item)
            self.player = queuePlayer
        }
    }
    
    func urlOfCurrentlyPlayingInPlayer(player : AVPlayer) -> URL {
        return ((player.currentItem?.asset) as? AVURLAsset)?.url ?? URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!
    }
    
    private var playerLooper: AVPlayerLooper?
    private var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
}

struct CustomVideoPlayer: UIViewRepresentable {
    let player: AVQueuePlayer

    func makeUIView(context: Context) -> PlayerView {
        let view = PlayerView()

        // Start the movie
        view.queuePlayer = player
        return view
    }
    
    func updateUIView(_ uiView: PlayerView, context: Context) {
    }
}

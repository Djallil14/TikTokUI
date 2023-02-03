import SwiftUI
import AVKit
import AVFoundation

class PlayerView: UIView {

    // make AVPlayerLayer the view's backing layer.
    override static var layerClass: AnyClass { AVPlayerLayer.self }
    
    // Get the layer associated Player
    var player: AVPlayer? {
        get {
            playerLayer.player
        }
        set {
            playerLayer.player = newValue
            playerLayer.videoGravity = .resizeAspectFill
            playerLayer.player?.play()
        }
    }
    
    // Create a Queue player and associate it with the Looper, to player video as loop like tiktok
    var queuePlayer: AVQueuePlayer? {
        didSet {
            let item = AVPlayerItem(url: urlOfCurrentlyPlayingInPlayer(player: queuePlayer!))
            playerLooper = AVPlayerLooper(player: queuePlayer!, templateItem: item)
            self.player = queuePlayer
        }
    }
    
    // get the player url to configure our looper item
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
        view.queuePlayer = player
        return view
    }
    
    func updateUIView(_ uiView: PlayerView, context: Context) {}
}

//  Created by Ky Nguyen

import AVFoundation
import AVKit
import UIKit

class VideoView: KNView {
    private let playButton = UIButton(imageName: "play")
    private let fullscreenButton = UIButton(imageName: "fullscreen")
    private var player: AVPlayer?
    var playerViewController: AVPlayerViewController?
    
    override func setupView() {
        backgroundColor = .black

        addSubviews(views: playButton)
        playButton.square(edge: 44)
        playButton.centerSuperview()
        
        fullscreenButton.contentEdgeInsets = UIEdgeInsets(space: 10)
        addSubviews(views: fullscreenButton)
        fullscreenButton.square(edge: 44)
        fullscreenButton.bottomRight(toView: self, bottomSpace: -16, rightSpace: -16)
    }
    
    func playVideo(url: String) {
        let videoURL = URL(string: url)
        player = AVPlayer(url: videoURL!)
        playerViewController = AVPlayerViewController()
        playerViewController?.player = player
        addSubviews(views: playerViewController!.view)
        playerViewController?.view.fillSuperView()
        playerViewController?.player?.play()
    }
}

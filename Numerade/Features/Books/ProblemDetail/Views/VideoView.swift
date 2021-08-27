//  Created by Ky Nguyen

import UIKit

class VideoView: KNView {
    let playButton = UIButton(imageName: "play")
    let fullscreenButton = UIButton(imageName: "fullscreen")
    
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
}

//  Created by Ky Nguyen

import UIKit
import Kingfisher
import func AVFoundation.AVMakeRect

extension UIImageView {
    func downloadImage(from url: String?, placeholder: UIImage? = nil) {
        guard let url = url, let nsurl = URL(string: url) else { return }
        kf.setImage(with: ImageResource(downloadURL: nsurl), placeholder: placeholder)
    }

    func changeColor(to color: UIColor) {
        guard let image = image else { return }
        self.image = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        tintColor = color
    }
}

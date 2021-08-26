//  Created by Ky Nguyen

import UIKit

class SubjectController: KNController {
    convenience init(title: String) {
        self.init(nibName: nil, bundle: nil)
        self.title = title
    }
    override func setupView() {
        let random = CGFloat(Int.random(in: 100...255))
        view.backgroundColor = UIColor(r: random, g: random, b: random)
    }
}

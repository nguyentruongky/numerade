//  Created by Ky Nguyen

import UIKit

class ProblemBottomView: KNView {
    let tabBar = TabBar()
    override func setupView() {
        addSubviews(views: tabBar)
        tabBar.horizontalSuperview()
        tabBar.topToSuperview()
        tabBar.height(56)
    }
}

extension ProblemBottomView {
    class TabBar: KNView {
        lazy var informationButton = createTabButton(title: "Information")
        lazy var moreAnswersButton = createTabButton(title: "More Answers")
        lazy var transcriptButton = createTabButton(title: "Transcript")
        let indicatorView = ViewFactory.createHorizontalLine(color: .black, lineHeight: 2)

        override func setupView() {
            addSubviews(views: informationButton, moreAnswersButton, transcriptButton)
            stackHorizontally(views: [informationButton, moreAnswersButton, transcriptButton],
                              viewSpaces: 16, leftSpace: 16, rightSpace: nil)

            let line = ViewFactory.createHorizontalLine(color: UIColor(hex: "#DBDBDB"))
            addSubviews(views: line)
            line.horizontalSuperview()
            line.bottomToSuperview()

            addSubviews(views: indicatorView)
            indicatorView.horizontal(toView: informationButton)
            indicatorView.bottomToSuperview()
        }

        func createTabButton(title: String) -> UIButton {
            return UIButton(title: title, titleColor: .color_0D0D0D, font: .main())
        }
    }
}

//  Created by Ky Nguyen

import UIKit

extension ProblemDetailUI {
    class ProblemBottomView: KNView {
        let tabBar = TabBar()
        let informationView = InformationView()
        override func setupView() {
            addSubviews(views: tabBar)
            tabBar.horizontalSuperview()
            tabBar.topToSuperview()
            tabBar.height(44)

            addSubviews(views: informationView)
            informationView.horizontalSuperview()
            informationView.verticalSpacing(toView: tabBar)
            informationView.bottomToSuperview()
        }
    }
}

extension ProblemDetailUI {
    class TabBar: KNView {
        lazy var informationButton = createTabButton(title: "Information")
        lazy var moreAnswersButton = createTabButton(title: "More Answers")
        lazy var transcriptButton = createTabButton(title: "Transcript")
        let indicatorView = ViewFactory.createHorizontalLine(color: .black, lineHeight: 2)

        override func setupView() {
            addSubviews(views: informationButton, moreAnswersButton, transcriptButton)
            stackHorizontally(views: [informationButton, moreAnswersButton, transcriptButton],
                              viewSpaces: 16, leftSpace: 16, rightSpace: nil)
            informationButton.verticalSuperview()
            moreAnswersButton.verticalSuperview()
            transcriptButton.verticalSuperview()

            let line = ViewFactory.createHorizontalLine(color: UIColor(hex: "#DBDBDB"))
            addSubviews(views: line)
            line.horizontalSuperview()
            line.bottomToSuperview()

            addSubviews(views: indicatorView)
            indicatorView.horizontal(toView: informationButton)
            indicatorView.bottomToSuperview()

            informationButton.addTarget(self, action: #selector(tappedInformation))
            moreAnswersButton.addTarget(self, action: #selector(tappedMoreAnswers))
            transcriptButton.addTarget(self, action: #selector(tappedTranscript))
        }

        @objc func tappedInformation() {
            setupIndicatorView(at: informationButton)
        }

        @objc func tappedMoreAnswers() {
            setupIndicatorView(at: moreAnswersButton)
        }

        @objc func tappedTranscript() {
            setupIndicatorView(at: transcriptButton)
        }

        private func setupIndicatorView(at view: UIView) {
            indicatorView.removeFromSuperview()
            view.addSubviews(views: indicatorView)
            indicatorView.horizontalSuperview()
            indicatorView.bottomToSuperview()
        }

        func createTabButton(title: String) -> UIButton {
            return UIButton(title: title, titleColor: .color_0D0D0D, font: .main())
        }
    }
}

extension ProblemDetailUI {
    class InformationView: KNView {
        let topicLabel = UILabel(font: .main(), color: UIColor(hex: "#383838"))
        let coverImageView = UIImageView(imageName: "book_placeholder", contentMode: .scaleAspectFill)
        let bookTitleLabel = UILabel(font: .main(size: 17), color: UIColor(hex: "#060606"), numberOfLines: 2)
        let chapterLabel = UILabel(font: .main(.bold, size: 15), color: UIColor(hex: "#5B5B5B"))
        let chapterNameLabel = UILabel(font: .main(size: 15), color: UIColor(hex: "#555555"))

        override func setupView() {
            addTopicView()
            addTextBookView()
        }

        private func addTopicView() {
            let label = UILabel(text: "Topic", font: .main(.bold, size: 16), color: .color_0D0D0D)
            addSubviews(views: label)
            label.topLeftToSuperView(topSpace: 16, leftSpace: 16)

            let topicView = UIView(background: UIColor(hex: "#EAEAF5"))
            topicView.setCorner(radius: 6)
            topicView.addSubviews(views: topicLabel)
            topicLabel.fillSuperView(space: UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6))

            addSubviews(views: topicView)
            topicView.left(toView: label)
            topicView.verticalSpacing(toView: label, space: 8)
        }

        private func addTextBookView() {
            let label = UILabel(text: "Textbook", font: .main(.bold, size: 16), color: .color_0D0D0D)
            addSubviews(views: label)
            label.leftToSuperview(space: 16)
            label.verticalSuperview(space: 120)

            coverImageView.setCorner(radius: 6)
            addSubviews(views: coverImageView)
            coverImageView.size(width: 110, height: 145)
            coverImageView.left(toView: label)
            coverImageView.verticalSpacing(toView: label, space: 8)
            coverImageView.bottomToSuperview(space: -48)

            addSubviews(views: bookTitleLabel)
            bookTitleLabel.leftHorizontalSpacing(toView: coverImageView, space: 8)
            bookTitleLabel.top(toView: coverImageView)

            addSubviews(views: chapterNameLabel)
            chapterNameLabel.left(toView: bookTitleLabel)
            chapterNameLabel.centerY(toView: coverImageView)

            addSubviews(views: chapterLabel)
            chapterLabel.left(toView: chapterNameLabel)
            chapterLabel.verticalSpacingDown(toView: chapterNameLabel, space: -4)
        }
    }
}

//  Created by Ky Nguyen

import UIKit

extension ProblemDetailUI {
    class InformationView: KNView {
        let topicLabel = UILabel(font: .main(), color: UIColor(hex: "#383838"))
        let coverImageView = UIImageView(imageName: "book_placeholder", contentMode: .scaleAspectFill)
        let bookTitleLabel = UILabel(font: .main(size: 17), color: UIColor(hex: "#060606"), numberOfLines: 2)
        let chapterLabel = UILabel(font: .main(.bold, size: 15), color: UIColor(hex: "#5B5B5B"))
        let chapterNameLabel = UILabel(font: .main(size: 17), color: UIColor(hex: "#333333"), numberOfLines: 0)

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
            bookTitleLabel.rightToSuperview(space: -16)
            bookTitleLabel.top(toView: coverImageView)

            addSubviews(views: chapterNameLabel)
            chapterNameLabel.horizontal(toView: bookTitleLabel)
            chapterNameLabel.verticalSpacing(toView: bookTitleLabel, space: 44)

            addSubviews(views: chapterLabel)
            chapterLabel.left(toView: chapterNameLabel)
            chapterLabel.verticalSpacingDown(toView: chapterNameLabel, space: -4)
        }
    }
}

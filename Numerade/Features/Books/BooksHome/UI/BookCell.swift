//  Created by Ky Nguyen

import UIKit

class BookCell: KNCollectionCell {
    let coverImageView = UIImageView(imageName: "book_placeholder", contentMode: .scaleAspectFit)
    let editionLabel = UILabel(text: "Edition", font: .main(size: 13), color: UIColor(hex: "#5B5B5B"))
    let titleLabel = UILabel(font: .main(.bold, size: 15), color: UIColor(hex: "#060606"), numberOfLines: 2)
    let questionsLabel = UILabel(text: "0 Questions", font: .main(size: 13), color: UIColor(hex: "#555555"))

    override func setupView() {
        contentView.addSubviews(views: coverImageView)
        coverImageView.horizontalSuperview()
        coverImageView.topToSuperview()
        coverImageView.height(toDimension: coverImageView.widthAnchor, multiplier: 0.9)
        coverImageView.setCorner(radius: 6)

        let textStack = UIStackView(axis: .vertical, distribution: .fill, alignment: .fill, space: 8)
        textStack.addArrangeViews(views: editionLabel, titleLabel, questionsLabel)
        contentView.addSubviews(views: textStack)
        textStack.horizontalSuperview()
        textStack.verticalSpacing(toView: coverImageView, space: 8)
    }

    func setData(_ data: Book) {
        coverImageView.downloadImage(from: data.coverImageUrl, placeholder: UIImage(named: "book_placeholder"))
        editionLabel.text = "\(data.edition) EDITION"
        titleLabel.text = data.title
        questionsLabel.text = "\(data.questionCount) Questions"
    }
}

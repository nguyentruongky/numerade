//  Created by Ky Nguyen

import UIKit

class BookCell: KNCollectionCell {
    let coverImageView = UIImageView(imageName: "book_placeholder", contentMode: .scaleAspectFill)
    let editionLabel = UILabel(text: "Edition", font: .main(size: 13), color: UIColor(hex: "#5B5B5B"))
    let titleLabel = UILabel(font: .main(.bold, size: 15), color: UIColor(hex: "#060606"), numberOfLines: 2)
    let questionsLabel = UILabel(text: "0 Questions", font: .main(size: 13), color: UIColor(hex: "#555555"))
    
    override func setupView() {
        contentView.addSubviews(views: coverImageView)
        coverImageView.horizontalSuperview()
        coverImageView.height(toDimension: coverImageView.widthAnchor, multiplier: 0.9)
        coverImageView.setCorner(radius: 6)
        
        let textStack = UIStackView(axis: .vertical, distribution: .fill, alignment: .fill, space: 8)
        textStack.addArrangeViews(views: editionLabel, titleLabel, questionsLabel)
        contentView.addSubviews(views: textStack)
        textStack.horizontalSuperview()
        textStack.verticalSpacing(toView: coverImageView, space: 8)
        textStack.bottomToSuperview()
        
        editionLabel.text = "1st EDITION"
        titleLabel.text = "Helps to make specific corners"
        questionsLabel.text = "100 Questions"
    }
}

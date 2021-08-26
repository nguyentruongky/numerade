//  Created by Ky Nguyen

import UIKit

class ChapterCell: KNTableCell {
    let orderLabel = UILabel(text: "1", font: .main(.bold, size: 16), color: UIColor(hex: "#5037FB"), alignment: .center)
    let nameLabel = UILabel(font: .main(.bold, size: 15), color: UIColor.color_0D0D0D)
    let questionsLabel = UILabel(text: "0 Questions", font: .main(size: 15), color: UIColor(hex: "#484848"))
    let taughtByLabel = UILabel(text: "Taught by", font: .main(size: 13), color: UIColor(hex: "#4C4C4C"))
    let teachersStackView = UIStackView()
    
    override func setupView() {
        let orderView = UIView(background: UIColor(hex: "#D4CEFE"))
        orderView.setCorner(radius: 6)
        orderView.addSubviews(views: orderLabel)
        orderLabel.horizontalSuperview()
        orderLabel.centerYToSuperview()
        
        let textStack = createTextStack()
        
        contentView.addSubviews(views: orderView)
        orderView.square(edge: 24)
        orderView.leftToSuperview(space: 24)
        orderView.centerYToSuperview()
        
        contentView.addSubviews(views: textStack)
        textStack.leftHorizontalSpacing(toView: orderView, space: 24)
        textStack.centerYToSuperview()
        textStack.rightToSuperview(space: -84)
        
        let nextIcon = UIImageView(imageName: "next")
        contentView.addSubviews(views: nextIcon)
        nextIcon.rightToSuperview(space: -24)
        nextIcon.centerYToSuperview()
        
        let line = ViewFactory.createHorizontalLine()
        contentView.addSubviews(views: line)
        line.horizontalSuperview(space: 24)
        line.bottomToSuperview()
        
        nameLabel.text = "Numerade is a venture-backed"
        for i in 0 ..< 3 {
            teachersStackView.addArrangeViews(views: createTeacherImageView())
        }
        
    }
    
    func createTeacherImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.square(edge: 24)
        imageView.setCorner(radius: 6)
        return imageView
    }
    
    func createTextStack() -> UIStackView {
        teachersStackView.axis = .horizontal
        teachersStackView.spacing = 4
        
        let taughtByView = UIView()
        taughtByView.addSubviews(views: taughtByLabel, teachersStackView)
        taughtByView.stackHorizontally(views: [taughtByLabel, teachersStackView], viewSpaces: 8, leftSpace: 0, rightSpace: nil)
        taughtByLabel.centerYToSuperview()
        teachersStackView.verticalSuperview()
        
        let stackView = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .fill, space: 12)
        stackView.addArrangeViews(views: nameLabel, questionsLabel, taughtByView)
        return stackView
    }
}


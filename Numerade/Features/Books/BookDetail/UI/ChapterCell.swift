//  Created by Ky Nguyen

import UIKit

class ChapterCell: KNTableCell {
    let orderLabel = UILabel(text: "1", font: .main(.bold, size: 16), color: UIColor(hex: "#5037FB"), alignment: .center)
    let nameLabel = UILabel(font: .main(.bold, size: 15), color: UIColor.color_0D0D0D)
    let questionsLabel = UILabel(text: "0 Questions", font: .main(size: 15), color: UIColor(hex: "#484848"))
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
    }
    
    func setData(_ data: Chapter) {
        orderLabel.text = "\(data.order)"
        nameLabel.text = data.title
        questionsLabel.text = "\(data.questionCount) Questions"
        showTeachersImage(teachers: data.teachers)
    }
    
    func showTeachersImage(teachers: [String]) {
        teachersStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for url in teachers {
            teachersStackView.addArrangeViews(views: createTeacherImageView(url: url))
        }
    }
    
    private func createTeacherImageView(url: String) -> UIImageView {
        let imageView = UIImageView(contentMode: .scaleAspectFill)
        imageView.downloadImage(from: url)
        imageView.backgroundColor = .green
        imageView.square(edge: 24)
        imageView.setCorner(radius: 6)
        return imageView
    }
    
    private func createTextStack() -> UIStackView {
        teachersStackView.axis = .horizontal
        teachersStackView.spacing = 4
        
        let taughtByLabel = UILabel(text: "Taught by", font: .main(size: 13), color: UIColor(hex: "#4C4C4C"))
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


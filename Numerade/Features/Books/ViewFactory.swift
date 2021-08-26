//  Created by Ky Nguyen

import UIKit

struct ViewFactory {
    static func createSearchTextField(placeholder: String) -> UITextField {
        let textField = UITextField(placeholder: placeholder, font: .main(), color: .white)
        textField.setPlaceholderColor(.white)
        textField.setView(.left, image: UIImage(named: "search"))
        textField.backgroundColor = UIColor(hex: "#1D16B5")
        textField.setCorner(radius: 12)
        return textField
    }

    /**
    Default color is: #D8D8D8
     */
    static func createHorizontalLine(color: UIColor = UIColor(hex: "#D8D8D8")) -> UIView {
        let line = UIView(background: color)
        line.horizontalSuperview()
        line.height(1)
        return line
    }

    static func createBackButton() -> UIButton {
        let backButton = UIButton(imageName: "back")
        backButton.square(edge: 44)
        return backButton
    }

}

class BookInfoView: KNView {
    let coverImageView = UIImageView(imageName: "book_placeholder", contentMode: .scaleAspectFill)
    let editionLabel = UILabel(text: "Edition", font: .main(size: 13), color: UIColor(hex: "#5B5B5B"))
    let titleLabel = UILabel(font: .main(.bold, size: 15), color: UIColor(hex: "#060606"), numberOfLines: 2)
    let questionsLabel = UILabel(text: "0 Questions", font: .main(size: 15), color: UIColor(hex: "#555555"))
    override func setupView() {
        coverImageView.setCorner(radius: 6)
        addSubviews(views: coverImageView)
        coverImageView.size(width: 88, height: 74)
        coverImageView.leftToSuperview()
        coverImageView.verticalSuperview()

        let textStack = UIStackView(axis: .vertical, distribution: .equalCentering, alignment: .fill, space: 8)
        textStack.addArrangeViews(views: editionLabel, titleLabel, questionsLabel)
        addSubviews(views: textStack)
        textStack.leftHorizontalSpacing(toView: coverImageView, space: 16)
        textStack.rightToSuperview()
        textStack.verticalSuperview()
    }

}

class NavigationBar: KNView {
    let topBgImageView = UIImageView(imageName: "top_background", contentMode: .scaleAspectFill)
    let searchTextField = ViewFactory.createSearchTextField(placeholder: "Search Chapters")
    let backButton = ViewFactory.createBackButton()

    override func setupView() {
        addSubviews(views: topBgImageView)
        topBgImageView.horizontalSuperview()
        topBgImageView.topToSuperview()
        topBgImageView.height(88)

        let backButton = ViewFactory.createBackButton()
        addSubviews(views: backButton)
        backButton.leftToSuperview(space: 8)
        backButton.topToSuperviewSafeArea(space: 8)

        addSubviews(views: searchTextField)
        searchTextField.leftHorizontalSpacing(toView: backButton, space: 8)
        searchTextField.rightToSuperview(space: -24)
        searchTextField.centerY(toView: backButton)
        searchTextField.height(50)
    }
}

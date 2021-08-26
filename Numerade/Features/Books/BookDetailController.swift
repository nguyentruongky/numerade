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

        let line = UIView(background: UIColor(hex: "#D8D8D8"))
        contentView.addSubviews(views: line)
        line.height(1)
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

class BookDetailController: KNController {
    let topBgImageView = UIImageView(imageName: "top_background", contentMode: .scaleAspectFill)
    lazy var searchTextField = createSearchTextField()
    let coverImageView = UIImageView(imageName: "book_placeholder", contentMode: .scaleAspectFill)
    let editionLabel = UILabel(text: "Edition", font: .main(size: 13), color: UIColor(hex: "#5B5B5B"))
    let titleLabel = UILabel(font: .main(.bold, size: 15), color: UIColor(hex: "#060606"), numberOfLines: 2)
    let questionsLabel = UILabel(text: "0 Questions", font: .main(size: 15), color: UIColor(hex: "#555555"))
    let bookView = UIView()
    lazy var tableView = UITableView(cells: [ChapterCell.self], source: self)
    var datasource = [String]()

    override func setupView() {
        view.backgroundColor = UIColor(hex: "#FEFFFE")
        tableView.backgroundColor = UIColor(hex: "#FEFFFE")

        view.addSubviews(views: topBgImageView)
        topBgImageView.horizontalSuperview()
        topBgImageView.topToSuperview()
        topBgImageView.height(88)

        let backButton = UIButton(imageName: "back")
        view.addSubviews(views: backButton)
        backButton.leftToSuperview(space: 8)
        backButton.topToSuperviewSafeArea(space: 8)
        backButton.square(edge: 44)

        view.addSubviews(views: searchTextField)
        searchTextField.leftHorizontalSpacing(toView: backButton, space: 8)
        searchTextField.rightToSuperview(space: -24)
        searchTextField.centerY(toView: backButton)
        searchTextField.height(50)

        setupBookView()

        let line = UIView(background: UIColor(hex: "#D8D8D8"))
        view.addSubviews(views: line)
        line.horizontalSuperview()
        line.height(1)
        line.verticalSpacing(toView: bookView, space: 24)

        let chapterLabel = UILabel(text: "Chapters", font: .main(.bold, size: 20), color: UIColor.color_0D0D0D)
        view.addSubviews(views: chapterLabel)
        chapterLabel.horizontalSuperview(space: 24)
        chapterLabel.verticalSpacing(toView: line, space: 24)

        view.addSubviews(views: tableView)
        tableView.horizontalSuperview()
        tableView.verticalSpacing(toView: chapterLabel, space: 24)
        tableView.bottomToSuperview()

        editionLabel.text = "1st EDITION"
        titleLabel.text = "Helps to make specific corners"
        questionsLabel.text = "100 Questions"
    }
}

extension BookDetailController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return datasource.count
        return 8
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChapterCell = tableView.dequeue(at: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

extension BookDetailController {
    func createSearchTextField() -> UITextField {
        let textField = UITextField(placeholder: "Search Chapters", font: .main(), color: .white)
        textField.setPlaceholderColor(.white)
        textField.setView(.left, image: UIImage(named: "search"))
        textField.backgroundColor = UIColor(hex: "#1D16B5")
        textField.setCorner(radius: 12)
        return textField
    }

    func setupBookView() {
        coverImageView.setCorner(radius: 6)
        bookView.addSubviews(views: coverImageView)
        coverImageView.size(width: 88, height: 74)
        coverImageView.leftToSuperview()
        coverImageView.verticalSuperview()

        let textStack = UIStackView(axis: .vertical, distribution: .equalCentering, alignment: .fill, space: 8)
        textStack.addArrangeViews(views: editionLabel, titleLabel, questionsLabel)
        bookView.addSubviews(views: textStack)
        textStack.leftHorizontalSpacing(toView: coverImageView, space: 16)
        textStack.rightToSuperview()
        textStack.verticalSuperview()

        view.addSubviews(views: bookView)
        bookView.horizontalSuperview(space: 24)
        bookView.verticalSpacing(toView: topBgImageView, space: 56)

    }
}

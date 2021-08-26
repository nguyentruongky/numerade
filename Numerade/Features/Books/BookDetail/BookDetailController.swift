//  Created by Ky Nguyen

import UIKit

class BookDetailController: KNController {
    let topBgImageView = UIImageView(imageName: "top_background", contentMode: .scaleAspectFill)
    let searchTextField = ViewFactory.createSearchTextField(placeholder: "Search Chapters")
    let bookView = BookInfoView()
    lazy var tableView = UITableView(cells: [ChapterCell.self], source: self)
    var datasource = [String]()

    override func setupView() {
        view.backgroundColor = UIColor(hex: "#FEFFFE")
        tableView.backgroundColor = UIColor(hex: "#FEFFFE")

        view.addSubviews(views: topBgImageView)
        topBgImageView.horizontalSuperview()
        topBgImageView.topToSuperview()
        topBgImageView.height(88)

        let backButton = ViewFactory.createBackButton()
        view.addSubviews(views: backButton)
        backButton.leftToSuperview(space: 8)
        backButton.topToSuperviewSafeArea(space: 8)

        view.addSubviews(views: searchTextField)
        searchTextField.leftHorizontalSpacing(toView: backButton, space: 8)
        searchTextField.rightToSuperview(space: -24)
        searchTextField.centerY(toView: backButton)
        searchTextField.height(50)

        view.addSubviews(views: bookView)
        bookView.horizontalSuperview(space: 24)
        bookView.verticalSpacing(toView: topBgImageView, space: 56)

        let line = ViewFactory.createHorizontalLine()
        view.addSubviews(views: line)
        line.horizontalSuperview()
        line.verticalSpacing(toView: bookView, space: 24)

        let chapterLabel = UILabel(text: "Chapters", font: .main(.bold, size: 20), color: UIColor.color_0D0D0D)
        view.addSubviews(views: chapterLabel)
        chapterLabel.horizontalSuperview(space: 24)
        chapterLabel.verticalSpacing(toView: line, space: 24)

        view.addSubviews(views: tableView)
        tableView.horizontalSuperview()
        tableView.verticalSpacing(toView: chapterLabel, space: 24)
        tableView.bottomToSuperview()

        bookView.editionLabel.text = "1st EDITION"
        bookView.titleLabel.text = "Helps to make specific corners"
        bookView.questionsLabel.text = "100 Questions"
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

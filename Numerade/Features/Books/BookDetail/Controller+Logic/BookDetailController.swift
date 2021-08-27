//  Created by Ky Nguyen

import UIKit

class BookDetailController: KNController {
    override var shouldGetDataViewDidLoad: Bool { true }
    var book: Book?
    let bookView = BookInfoView()
    lazy var tableView = UITableView(cells: [ChapterCell.self], source: self)
    var datasource = [Chapter]()
    let navigationBar = NavigationBar()
    lazy var interaction = BookDetailInteraction(controller: self)

    override func setupView() {
        navigationBar.backButton.addTarget(self, action: #selector(popBack))
        view.backgroundColor = UIColor(hex: "#FEFFFE")
        tableView.backgroundColor = UIColor(hex: "#FEFFFE")

        view.addSubviews(views: navigationBar)
        navigationBar.horizontalSuperview()
        navigationBar.topToSuperview()
        navigationBar.height(88)

        view.addSubviews(views: bookView)
        bookView.horizontalSuperview(space: 24)
        bookView.verticalSpacing(toView: navigationBar, space: 56)

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

    override func getData() {
        interaction.getData()
        if let book = book {
            bookView.setData(book)
        }
    }
}

extension BookDetailController {
    func setDataToUI(bookDetail: BookDetail) {
        datasource = bookDetail.chapters
    }
}

extension BookDetailController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChapterCell = tableView.dequeue(at: indexPath)
        cell.setData(datasource[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChapterDetailController()
        vc.book = book
        vc.chapter = datasource[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

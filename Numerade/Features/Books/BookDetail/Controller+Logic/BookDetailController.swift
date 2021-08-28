//  Created by Ky Nguyen

import UIKit

class BookDetailController: KNController {
    static func pushed(from source: UIViewController, withData book: Book) {
        let vc = BookDetailController()
        vc.book = book
        source.navigationController?.pushViewController(vc, animated: true)
    }
    override var shouldGetDataViewDidLoad: Bool { true }
    var book: Book?
    private lazy var interaction = BookDetailInteraction(controller: self)
    private var datasource = [Chapter]()
    
    private let navigationBar = NavigationBar()
    private let bookView = BookInfoView()
    private let chapterLabel = UILabel(text: "Chapters", font: .main(.bold, size: 20), color: UIColor.color_0D0D0D)
    private lazy var tableView = UITableView(cells: [ChapterCell.self], source: self)

    override func setupView() {
        navigationBar.backButton.addTarget(self, action: #selector(popBack))
        view.backgroundColor = UIColor(hex: "#FEFFFE")
        tableView.backgroundColor = UIColor(hex: "#FEFFFE")

        setupNavigationBar()
        setupBookView()
        setupChapterLabel()
        setupTableView()
    }

    override func getData() {
        interaction.getData()
        if let book = book {
            bookView.setData(book)
        }
    }
}

extension BookDetailController {
    private func setupNavigationBar() {
        view.addSubviews(views: navigationBar)
        navigationBar.horizontalSuperview()
        navigationBar.topToSuperview()
    }
    
    private func setupBookView() {
        view.addSubviews(views: bookView)
        bookView.horizontalSuperview(space: 24)
        bookView.verticalSpacing(toView: navigationBar, space: 24)
    }
    
    private func setupChapterLabel() {
        let line = ViewFactory.createHorizontalLine()
        view.addSubviews(views: line)
        line.horizontalSuperview()
        line.verticalSpacing(toView: bookView, space: 24)

        view.addSubviews(views: chapterLabel)
        chapterLabel.horizontalSuperview(space: 24)
        chapterLabel.verticalSpacing(toView: line, space: 24)
    }
    
    private func setupTableView() {
        view.addSubviews(views: tableView)
        tableView.horizontalSuperview()
        tableView.verticalSpacing(toView: chapterLabel, space: 24)
        tableView.bottomToSuperview()
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
        ChapterDetailController.pushed(from: self,
                                       book: book,
                                       chapter: datasource[indexPath.row])
    }
}

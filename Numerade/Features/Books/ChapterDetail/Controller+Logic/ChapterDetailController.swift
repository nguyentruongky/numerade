//  Created by Ky Nguyen

import UIKit

class ChapterDetailController: KNController {
    static func pushed(from source: UIViewController, book: Book?, chapter: Chapter) {
        let vc = ChapterDetailController()
        vc.book = book
        vc.chapter = chapter
        source.navigationController?.pushViewController(vc, animated: true)
    }
    override var shouldGetDataViewDidLoad: Bool { true }
    lazy var interaction = ChapterDetailInteraction(controller: self)
    var book: Book?
    var chapter: Chapter?
    var datasource = [Problem]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let bookView = BookInfoView()
    private lazy var tableView = UITableView(cells: [ProblemCell.self], source: self)
    private let navigationBar = NavigationBar()

    override func setupView() {
        view.backgroundColor = UIColor(hex: "#FEFFFE")
        tableView.backgroundColor = UIColor(hex: "#FEFFFE")

        setupNavigationBar()
        setupBookView()
        setupTableView()
    }

    override func getData() {
        if let book = book {
            bookView.setData(book)
        }

        interaction.getData()
        navigationBar.searchTextField.text = chapter?.title
    }
}

extension ChapterDetailController {
    private func setupNavigationBar() {
        navigationBar.searchTextField.isEnabled = false
        navigationBar.searchTextField.setView(.left, space: 16)
        navigationBar.searchTextField.setView(.right, space: 16)
        navigationBar.backButton.addTarget(self, action: #selector(popBack))

        view.addSubviews(views: navigationBar)
        navigationBar.horizontalSuperview()
        navigationBar.topToSuperview()
    }
    
    private func setupBookView() {
        view.addSubviews(views: bookView)
        bookView.horizontalSuperview(space: 24)
        bookView.verticalSpacing(toView: navigationBar, space: 24)

        let line = ViewFactory.createHorizontalLine()
        view.addSubviews(views: line)
        line.horizontalSuperview()
        line.verticalSpacing(toView: bookView, space: 24)
    }

    private func setupTableView() {
        view.addSubviews(views: tableView)
        tableView.horizontalSuperview()
        tableView.verticalSpacing(toView: bookView, space: 48)
        tableView.bottomToSuperview()
    }
}

extension ChapterDetailController {
    func setDataToUI(_ data: ChapterDetail) {
        datasource = data.problems
    }
}

extension ChapterDetailController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProblemCell = tableView.dequeue(at: indexPath)
        cell.setData(datasource[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        280
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ProblemDetailController.presented(from: self,
                                          book: book,
                                          chapter: chapter,
                                          problem: datasource[indexPath.row])
    }
}

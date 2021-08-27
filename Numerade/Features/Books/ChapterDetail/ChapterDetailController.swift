//  Created by Ky Nguyen

import UIKit

class ChapterDetailController: KNController {
    override var shouldGetDataViewDidLoad: Bool { true }
    lazy var interaction = ChapterDetailInteraction(controller: self)
    let bookView = BookInfoView()
    var book: Book?
    var chapter: Chapter?
    
    lazy var tableView = UITableView(cells: [ProblemCell.self], source: self)
    var datasource = [Problem]() {
        didSet {
            tableView.reloadData()
        }
    }
    let navigationBar = NavigationBar()
    
    override func setupView() {
        view.backgroundColor = UIColor(hex: "#FEFFFE")
        tableView.backgroundColor = UIColor(hex: "#FEFFFE")
        
        formatNavigationBar()
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
    }
    
    override func getData() {
        if let book = book {
            bookView.setData(book)
        }
        
        interaction.getData()
        navigationBar.searchTextField.text = chapter?.title
    }
    
    func formatNavigationBar() {
        navigationBar.searchTextField.isEnabled = false
        navigationBar.searchTextField.setView(.left, space: 16)
        navigationBar.searchTextField.setView(.right, space: 16)
        navigationBar.backButton.addTarget(self, action: #selector(popBack))
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
}

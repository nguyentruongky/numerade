//  Created by Ky Nguyen

import SwipeMenuViewController
import UIKit

class BooksController: KNController {
    override var shouldGetDataViewDidLoad: Bool { true }
    let swipeMenuView = SwipeMenuView(frame: .zero)
    let tabBar = TopTabBarView()
    var controllers = [SubjectController]()

    var booksDatasource = [String: [Book]]() {
        didSet {
            reloadData()
        }
    }
    var categories = [String]() {
        didSet {
            controllers = categories.map { [weak self] category in
                let vc = SubjectController(category: category)
                vc.datasource = self
                vc.delegate = self
                return vc
            }
            tabBar.setupView(titles: categories)
        }
    }
    lazy var interaction = BookInteraction(controller: self)

    let topBgImageView = UIImageView(imageName: "top_background", contentMode: .scaleAspectFill)
    let searchTextField = ViewFactory.createSearchTextField(placeholder: "Search All Books")

    override func setupView() {
        navigationController?.navigationBar.isHidden = true

        view.addSubviews(views: topBgImageView)
        topBgImageView.horizontalSuperview()
        topBgImageView.topToSuperview()
        topBgImageView.height(160)

        view.addSubviews(views: searchTextField)
        searchTextField.horizontalSuperview(space: 24)
        searchTextField.topToSuperviewSafeArea(space: 8)
        searchTextField.height(50)

        setupSwipeView()
    }

    override func getData() {
        interaction.getData()
    }

    func reloadData() {
        swipeMenuView.reloadData()
        swipeMenuView.tabView?.isHidden = true
        controllers.forEach {
            $0.getData()
        }
    }
}

extension BooksController: SubjectDatasource {
    func dataForCategory(_ category: String) -> [Book] {
        if category.lowercased() == "all" {
            var books = [Book]()
            for (_, booksInCategory) in booksDatasource {
                books.append(contentsOf: booksInCategory)
            }
            return books
        }
        return booksDatasource[category] ?? []
    }
}

extension BooksController: SubjectDelegate {
    func showBookDetail(book: Book) {
        let vc = BookDetailController()
        vc.book = book
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension BooksController: SwipeMenuViewDataSource, SwipeMenuViewDelegate {
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return controllers.count
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return controllers[index].title ?? ""
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        return controllers[index]
    }

    @objc public func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        if tabBar.items.isEmpty { return }
        tabBar.items[fromIndex].isSelected = false
        tabBar.items[toIndex].isSelected = true
    }
}

extension BooksController {
    func setupSwipeView() {
        let screenSize = UIScreen.main.bounds
        swipeMenuView.frame = CGRect(x: 0,
                                     y: 100,
                                     width: screenSize.width,
                                     height: screenSize.height - 160)
        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self

        view.addSubviews(views: swipeMenuView)
        swipeMenuView.translatesAutoresizingMaskIntoConstraints = false
        swipeMenuView.horizontalSuperview()
        swipeMenuView.verticalSpacing(toView: topBgImageView, space: -44)
        swipeMenuView.bottomToSuperview()

        swipeMenuView.tabView?.isHidden = true
        swipeMenuView.addSubviews(views: tabBar)
        tabBar.horizontalSuperview()
        tabBar.topToSuperview()
        tabBar.height(44)
    }
}

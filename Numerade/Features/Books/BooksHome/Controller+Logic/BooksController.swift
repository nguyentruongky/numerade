//  Created by Ky Nguyen

import SwipeMenuViewController
import UIKit

class BooksController: KNController {
    // MARK: - LOGIC VARIABLES
    override var shouldGetDataViewDidLoad: Bool { true }
    private lazy var interaction = BooksInteraction(controller: self)
    var booksDatasource = [String: [Book]]() {
        didSet {
            reloadData()
        }
    }
    
    func reloadData() {
        swipeMenuView.reloadData()
        swipeMenuView.tabView?.isHidden = true
        controllers.forEach {
            $0.getData()
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
            topTabBar.setupView(titles: categories)
        }
    }

    // MARK: - UI ELEMENTS
    private let topBgImageView = UIImageView(imageName: "top_background", contentMode: .scaleAspectFill)
    private let searchTextField = ViewFactory.createSearchTextField(placeholder: "Search All Books")
    private let swipeMenuView = SwipeMenuView(frame: .zero)
    private let topTabBar = TopTabBarView()
    private var controllers = [SubjectController]()

    override func setupView() {
        navigationController?.navigationBar.isHidden = true

        setupTopBackground()
        setupSearchTextField()
        setupSwipeView()
    }

    override func getData() {
        interaction.getData()
    }
}

// MARK: - SETUP UI
extension BooksController {
    private func setupTopBackground() {
        view.addSubviews(views: topBgImageView)
        topBgImageView.horizontalSuperview()
        topBgImageView.topToSuperview()
        topBgImageView.height(140)
    }
    
    private func setupSearchTextField() {
        view.addSubviews(views: searchTextField)
        searchTextField.horizontalSuperview(space: 24)
        searchTextField.topToSuperviewSafeArea(space: 8)
        searchTextField.height(36)
    }
    
    private func setupSwipeView() {
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
        swipeMenuView.addSubviews(views: topTabBar)
        topTabBar.horizontalSuperview()
        topTabBar.topToSuperview()
        topTabBar.height(44)
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
        if topTabBar.items.isEmpty { return }
        topTabBar.items[fromIndex].isSelected = false
        topTabBar.items[toIndex].isSelected = true
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

// MARK: ACTIONS
extension BooksController: SubjectDelegate {
    func showBookDetail(book: Book) {
        push(to: .bookDetail(book: book))
    }
}

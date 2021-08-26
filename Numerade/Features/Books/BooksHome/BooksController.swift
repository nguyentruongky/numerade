//  Created by Ky Nguyen

import SwipeMenuViewController
import UIKit

class BooksController: KNController {
    let swipeMenuView = SwipeMenuView(frame: .zero)
    let tabBar = TopTabBarView()

    let titles = [
        "All",
        "Physics",
        "Math",
        "Chemistry",
        "Biology",
        "Economics",
        "Psychology"
    ]

    var controllers = [
        SubjectController(title: "All"),
        SubjectController(title: "Physics"),
        SubjectController(title: "Math"),
        SubjectController(title: "Chemistry"),
        SubjectController(title: "Biology"),
        SubjectController(title: "Economics"),
        SubjectController(title: "Psychology")
    ]

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

        tabBar.setupView(titles: titles)
    }
}

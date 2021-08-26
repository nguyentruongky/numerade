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

    override func setupView() {
        navigationController?.navigationBar.isHidden = true

        view.addSubviews(views: topBgImageView)
        topBgImageView.horizontalSuperview()
        topBgImageView.topToSuperview()
        topBgImageView.height(160)

        view.addSubviews(views: searchTextField)
        searchTextField.horizontalSuperview(space: 32)
        searchTextField.topToSuperviewSafeArea(space: 8)
        searchTextField.height(50)

        setupSwipeView()
    }

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

    lazy var searchTextField = createSearchTextField()
    func createSearchTextField() -> UITextField {
        let textField = UITextField(placeholder: "Search All Books", font: .main(), color: .white)
        textField.setPlaceholderColor(.white)
        textField.setView(.left, image: UIImage(named: "search"))
        textField.backgroundColor = UIColor(hex: "#1D16B5")
        textField.setCorner(radius: 12)
        return textField
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

class TabItemButton: UIButton {
    private let inactiveColor = UIColor.clear
    private let activeColor = UIColor(hex: "#1D16B5")
    let nameLabel = UILabel(font: .main(.bold, size: 15), color: .white, alignment: .center)
    convenience init(title: String) {
        self.init(frame: .zero)
        nameLabel.text = title
        setupView()
    }
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? activeColor : inactiveColor
        }
    }
    func setupView() {
        backgroundColor = inactiveColor
        setCorner(radius: 5)
        nameLabel.textColor = .white
        addSubviews(views: nameLabel)
        nameLabel.horizontalSuperview(space: 16)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.centerYToSuperview()
    }
}

class TopTabBarView: KNView {
    var items = [TabItemButton]()
    func setupView(titles: [String]) {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12

        for item in titles {
            let tab = TabItemButton(title: item)
            tab.height(32)
            items.append(tab)
            stackView.addArrangeViews(views: tab)
        }

        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubviews(views: stackView)
        stackView.horizontalSuperview(space: 16)
        stackView.centerYToSuperview()

        addSubviews(views: scrollView)
        scrollView.fillSuperView()
        items[0].isSelected = true
        backgroundColor = .clear
    }
}

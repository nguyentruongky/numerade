//  Created by Ky Nguyen

import UIKit

class TabItemButton: UIButton {
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? activeColor : inactiveColor
        }
    }

    private let inactiveColor = UIColor.clear
    private let activeColor = UIColor(hex: "#1D16B5")
    private let nameLabel = UILabel(font: .main(.bold, size: 15), color: .white, alignment: .center)

    convenience init(title: String) {
        self.init(frame: .zero)
        nameLabel.text = title
        setupView()
    }

    private func setupView() {
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
    private let stackView = UIStackView()

    func setupView(titles: [String]) {
        backgroundColor = .clear

        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        items = []

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
        if titles.isEmpty == false {
            items[0].isSelected = true
        }
    }
}

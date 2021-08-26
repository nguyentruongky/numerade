//  Created by Ky Nguyen

import UIKit

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

//  Created by Ky Nguyen

import UIKit

extension ProblemDetailUI {
    class MoreAnswerCell: ProblemCell {
        override func setupView() {
            problemImageView.backgroundColor = UIColor(hex: "#D2D2D2")
            problemImageView.setCorner(radius: 6)
            contentView.addSubviews(views: problemImageView)
            problemImageView.horizontalSuperview(space: 24)
            problemImageView.topToSuperview()
            problemImageView.height(150)

            contentView.addSubviews(views: teacherNameLabel)
            teacherNameLabel.left(toView: problemImageView)
            teacherNameLabel.verticalSpacing(toView: problemImageView, space: 16)

            contentView.addSubviews(views: questionLabel)
            questionLabel.horizontal(toView: problemImageView)
            questionLabel.verticalSpacing(toView: teacherNameLabel, space: 8)

            let line = ViewFactory.createHorizontalLine()
            contentView.addSubviews(views: line)
            line.horizontalSuperview(space: 24)
            line.bottomToSuperview(space: -24)
        }
    }

    class MoreAnswerView: KNView, UITableViewDataSource, UITableViewDelegate {
        private let rowHeight: CGFloat = 280
        private lazy var tableView = UITableView(cells: [MoreAnswerCell.self], source: self)
        private var heightConstraint: NSLayoutConstraint?
        var datasource = [Problem]() {
            didSet {
                tableView.reloadData()
                heightConstraint?.constant = CGFloat(datasource.count) * rowHeight
            }
        }

        override func setupView() {
            tableView.isScrollEnabled = false
            addSubviews(views: tableView)
            tableView.fillSuperView(space: UIEdgeInsets(top: 16))
            heightConstraint = tableView.height(280)
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return datasource.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: MoreAnswerCell = tableView.dequeue(at: indexPath)
            cell.setData(datasource[indexPath.row])
            return cell
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            rowHeight
        }
    }
}

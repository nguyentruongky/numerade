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

            teacherImageView.setCorner(radius: 6)
            contentView.addSubviews(views: teacherImageView)
            teacherImageView.bottomRight(toView: problemImageView, bottomSpace: -8, rightSpace: -8)
            teacherImageView.square(edge: 48)

            contentView.addSubviews(views: orderLabel)
            orderLabel.left(toView: problemImageView)
            orderLabel.verticalSpacing(toView: problemImageView, space: 16)

            contentView.addSubviews(views: teacherNameLabel)
            teacherNameLabel.right(toView: problemImageView)
            teacherNameLabel.centerY(toView: orderLabel)

            contentView.addSubviews(views: questionLabel)
            questionLabel.horizontal(toView: problemImageView)
            questionLabel.verticalSpacing(toView: orderLabel, space: 8)

            let line = ViewFactory.createHorizontalLine()
            contentView.addSubviews(views: line)
            line.horizontalSuperview(space: 24)
            line.bottomToSuperview(space: -24)

            orderLabel.text = "Problem 1"
            questionLabel.text = "Numerade is a venture-backed, high-growth education technology startup based in Los Angeles."
            teacherNameLabel.text = "Numerade"

        }
    }

    class MoreAnswerView: KNView, UITableViewDataSource, UITableViewDelegate {
        lazy var tableView = UITableView(cells: [MoreAnswerCell.self], source: self)

        override func setupView() {
            addSubviews(views: tableView)
            tableView.fillSuperView(space: UIEdgeInsets(top: 16))

            height(1000)
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //        return datasource.count
            return 8
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: MoreAnswerCell = tableView.dequeue(at: indexPath)
            return cell
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            280
        }
    }
}

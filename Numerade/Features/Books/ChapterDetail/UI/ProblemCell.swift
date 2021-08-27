//  Created by Ky Nguyen

import UIKit

class ProblemCell: KNTableCell {
    let problemImageView = UIImageView(contentMode: .scaleAspectFill)
    let teacherImageView = UIImageView(imageName: "user", contentMode: .scaleAspectFill)
    let teacherNameLabel = UILabel(font: .main(.bold, size: 15), color: .color_0D0D0D)
    let orderLabel = UILabel(font: .main(), color: .color_0D0D0D)
    let questionLabel = UILabel(font: .main(), color: .color_0D0D0D, numberOfLines: 2)
    
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
    }
    
    func setData(_ data: Problem) {
        problemImageView.downloadImage(from: data.imageUrl)
        teacherImageView.downloadImage(from: data.teacherImageUrl)
        teacherNameLabel.text = data.teacherName
        orderLabel.text = "Problem \(data.order)"
        questionLabel.text = data.content
    }
}

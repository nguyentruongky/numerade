//  Created by Ky Nguyen

import UIKit

class SubjectController: KNController {
    var collectionView: UICollectionView!
    var datasource = [String]()

    convenience init(title: String) {
        self.init(nibName: nil, bundle: nil)
        self.title = title
    }

    override func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let screenWidth = UIScreen.main.bounds.width
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        let itemWidth = (screenWidth - 48) / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 68)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(space: 16)
        collectionView.register(BookCell.self, forCellWithReuseIdentifier: "BookCell")

        view.addSubviews(views: collectionView)
        collectionView.fillSuperView()
    }
}

class BookCell: KNCollectionCell {
    let coverImageView = UIImageView(imageName: "book_placeholder", contentMode: .scaleAspectFill)
    let editionLabel = UILabel(text: "Edition", font: .main(size: 13), color: UIColor(hex: "#5B5B5B"))
    let titleLabel = UILabel(font: .main(.bold, size: 15), color: UIColor(hex: "#060606"), numberOfLines: 2)
    let questionsLabel = UILabel(text: "0 Questions", font: .main(size: 13), color: UIColor(hex: "#555555"))

    override func setupView() {
        contentView.addSubviews(views: coverImageView)
        coverImageView.horizontalSuperview()
        coverImageView.height(toDimension: coverImageView.widthAnchor, multiplier: 0.9)
        coverImageView.setCorner(radius: 6)

        let textStack = UIStackView(axis: .vertical, distribution: .fill, alignment: .fill, space: 8)
        textStack.addArrangeViews(views: editionLabel, titleLabel, questionsLabel)
        contentView.addSubviews(views: textStack)
        textStack.horizontalSuperview()
        textStack.verticalSpacing(toView: coverImageView, space: 8)
        textStack.bottomToSuperview()

        editionLabel.text = "1st EDITION"
        titleLabel.text = "Helps to make specific corners"
        questionsLabel.text = "100 Questions"
    }
}

extension SubjectController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BookCell = collectionView.dequeue(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

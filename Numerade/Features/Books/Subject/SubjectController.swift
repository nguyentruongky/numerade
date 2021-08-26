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

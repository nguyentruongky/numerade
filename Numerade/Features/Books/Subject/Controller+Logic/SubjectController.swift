//  Created by Ky Nguyen

import UIKit

protocol SubjectDatasource: AnyObject {
    func dataForCategory(_ category: String) -> [Book]
}

protocol SubjectDelegate: AnyObject {
    func showBookDetail(book: Book)
}

class SubjectController: KNController {
    override var shouldGetDataViewDidLoad: Bool { true }
    var collectionView: UICollectionView!
    var localDatasource = [Book]() {
        didSet {
            collectionView.reloadData()
        }
    }
    var category: String?
    var showBookDetailAction: ((BookDetailController) -> Void)?
    weak var datasource: SubjectDatasource?
    weak var delegate: SubjectDelegate?

    convenience init(category: String) {
        self.init(nibName: nil, bundle: nil)
        self.category = category
        self.title = category
        setupView()
    }

    override func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let screenWidth = UIScreen.main.bounds.width
        layout.minimumLineSpacing = 48
        layout.minimumInteritemSpacing = 16
        let itemWidth = (screenWidth - 48) / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 88)

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

    override func getData() {
        guard let category = category else { return }
        if category.lowercased() == "all" {

        }
        localDatasource = datasource?.dataForCategory(category.lowercased()) ?? []
    }
}

extension SubjectController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return localDatasource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BookCell = collectionView.dequeue(at: indexPath)
        cell.setData(localDatasource[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.zoomIn(true, complete: {
            self.delegate?.showBookDetail(book: self.localDatasource[indexPath.row])
        })
    }
}

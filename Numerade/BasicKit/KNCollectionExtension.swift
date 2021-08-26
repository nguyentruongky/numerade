//  Created by Ky Nguyen

import UIKit

extension UICollectionView {
    convenience init(cells: [AnyClass], delegate: UICollectionViewDelegate? = nil, datasource: UICollectionViewDataSource? = nil) {
        self.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        for c in cells {
            register(c, forCellWithReuseIdentifier: String(describing: c.self))
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        self.dataSource = datasource
        self.delegate = delegate
    }
    convenience init(cells: [AnyClass], source: UICollectionViewDelegate&UICollectionViewDataSource) {
        self.init(cells: cells, delegate: source, datasource: source)
    }
    func dequeue<T>(at indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
        return cell
    }
}

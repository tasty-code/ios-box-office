//
//  UICollectionView+Extension.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/10.
//

import UIKit

extension UICollectionView {

    func register<T: UICollectionViewCell>(cell: T.Type) {

        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeue<T: UICollectionViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {

        return dequeueReusableCell(withReuseIdentifier: cell.reuseIdentifier, for: indexPath) as! T
    }
}

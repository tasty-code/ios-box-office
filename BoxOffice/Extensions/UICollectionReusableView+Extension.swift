//
//  UICollectionReusableView+Extension.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/10.
//

import UIKit

extension UICollectionReusableView {

    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

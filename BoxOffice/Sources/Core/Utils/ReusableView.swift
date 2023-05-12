//
//  ReusableView.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/05/02.
//

import Foundation

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

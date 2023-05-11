//
//  Gettable.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/05/11.
//

import Foundation

protocol Gettable {
    static var identifier: String { get }
}

extension Gettable {
    static var identifier: String {
        return String(describing: self)
    }
}

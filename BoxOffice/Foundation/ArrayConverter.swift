//
//  ArrayConverter.swift
//  BoxOffice
//
//  Created by Kim EenSung on 3/14/24.
//

import Foundation

extension Array where Element == String {
    func joinedWithComma() -> String {
        self.joined(separator: ", ")
    }
}

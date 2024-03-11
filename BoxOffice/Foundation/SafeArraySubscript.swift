//
//  SafeArraySubscript.swift
//  BoxOffice
//
//  Created by Kim EenSung on 3/8/24.
//

import Foundation

extension Array {
    subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}

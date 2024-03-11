//
//  IntFormatter.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/21/24.
//

import Foundation

extension Int {
    func formatNumber() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let result = formatter.string(from: NSNumber(value: self)) else {
            return ""
        }
        return result
    }
}

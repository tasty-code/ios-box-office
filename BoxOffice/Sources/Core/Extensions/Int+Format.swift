//
//  Int+Format.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/05/03.
//

import Foundation

extension Int {
    private static let decimalNumberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
    
    func formatWithCommas() -> String? {
        return Self.decimalNumberFormatter.string(from: self as NSNumber)
    }
}

extension UInt {
    private static let decimalNumberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
    
    func formatWithCommas() -> String? {
        return Self.decimalNumberFormatter.string(from: self as NSNumber)
    }
}

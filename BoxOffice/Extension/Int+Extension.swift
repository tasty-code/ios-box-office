//
//  Int+Extension.swift
//  BoxOffice
//
//  Created by Matthew on 2/22/24.
//

import Foundation

extension Int {
    func numberFormatter() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard
            let result = numberFormatter.string(from: NSNumber(value: self))
        else {
            return ""
        }
        return result
    }
}

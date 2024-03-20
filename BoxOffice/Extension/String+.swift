//
//  String+.swift
//  BoxOffice
//
//  Created by dopamint on 3/19/24.
//

import Foundation

extension String {
    func formatNumberString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let number = Double(self),
              let result = formatter.string(from: NSNumber(value: number))
        else {
            return ""
        }
        return result
    }
}

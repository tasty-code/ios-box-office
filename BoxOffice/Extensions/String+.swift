//
//  String+.swift
//  BoxOffice
//
//  Created by Jin-Mac on 3/20/24.
//

import Foundation

extension String {
    
    func formatDecimalNumberString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        guard let number = Double(self),
              let changedString = formatter.string(from: NSNumber(value: number)) else {
            return self
        }
        return changedString
    }
}

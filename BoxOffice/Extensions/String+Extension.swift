//
//  String+Extension.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/15.
//

import Foundation

extension String {
    private var changeToInt: Int {
        return Int(self) ?? 0
    }

    func formatted() -> String {
        
        let number = self.changeToInt
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: number)) else { return "" }

        return formattedNumber
    }
}

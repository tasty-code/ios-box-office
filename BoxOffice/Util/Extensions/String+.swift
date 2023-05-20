//
//  String+.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/09.
//

import Foundation

extension String {

    private enum StringConstant {
        static let hyphen = "-"
    }

    func without(_ characterSet: String) -> String {
        let charSet = CharacterSet(charactersIn: characterSet)
        let trimmedString = self.components(separatedBy: charSet).joined()

        return trimmedString
    }

    var yearMonthDaySplitDash: String {
        guard self.count == 8 else { return self }

        var strings = Array(self)
        strings.insert(contentsOf: StringConstant.hyphen, at: 4)
        strings.insert(contentsOf: StringConstant.hyphen, at: 7)

        return String(strings)
    }

}

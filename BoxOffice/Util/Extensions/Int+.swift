//
//  Int+.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/11.
//

import Foundation

extension Int {

    var decimalizedString: String {
        guard let decimalizedString = Formatter.decimalStyleNumber.string(from: self as NSNumber) else { return "" }
        return decimalizedString
    }

}


//
//  Formatter+.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/11.
//

import Foundation

extension Formatter {

    static let decimalStyleNumber: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        return formatter
    }()

    static let dateWithDash: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter
    }()

}

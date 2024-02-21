//
//  DateFormatable.swift
//  BoxOffice
//
//  Created by Matthew on 2/20/24.
//

import Foundation

protocol DateFormattable {
    func makeDataFormatToString(date: Date) -> String
}

extension DateFormattable {
    func makeDataFormatToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: date)
    }
}

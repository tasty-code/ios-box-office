//
//  DateFormatable.swift
//  BoxOffice
//
//  Created by Matthew on 2/20/24.
//

import Foundation

protocol DateFormattable {
    func makeDataFormatToString(date: Date, format: String) -> String
}

extension DateFormattable {
    func makeDataFormatToString(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}

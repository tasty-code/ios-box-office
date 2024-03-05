//
//  DailyFormatter.swift
//  BoxOffice
//
//  Created by Roh on 2/24/24.
//

import Foundation

protocol DailyFormatter {
    func dailyFormatter(format: String) -> String
}

extension DailyFormatter {
    func dailyFormatter(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format

        let current_date_string = formatter.string(from: Date() - 86400)
        return current_date_string
    }
}

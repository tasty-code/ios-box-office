//
//  Date+.swift
//  BoxOffice
//
//  Created by dopamint on 3/19/24.
//

import Foundation

extension Date {
    var yesterday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let today = Date()
        let timezone = TimeZone.autoupdatingCurrent
        let secondsFromGMT = timezone.secondsFromGMT(for: today)
        let localizedDate = today.addingTimeInterval(TimeInterval(secondsFromGMT))
        let yesterday = Calendar(identifier: .gregorian).date(byAdding: .day, value: -2, to: localizedDate)
        guard let dateString = dateFormatter.string(for: yesterday) else {
            return "알 수 없는 날짜"
        }
        return dateString
    }
    
    func addHyphen(dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyyMMdd"
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy-MM-dd"
            return outputFormatter.string(from: date)
        }
        return nil
    }
}

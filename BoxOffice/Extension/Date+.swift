//
//  Date+.swift
//  BoxOffice
//
//  Created by dopamint on 3/19/24.
//

import Foundation

extension Date {
    static let yyyyMMdd = "yyyyMMdd"
    static let yyyyMMddHyphen = "yyyy-MM-dd"
    
    func yesterday(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let today = Date()
        let timezone = TimeZone.autoupdatingCurrent
        let secondsFromGMT = timezone.secondsFromGMT(for: today)
        let localizedDate = today.addingTimeInterval(TimeInterval(secondsFromGMT))
        let yesterday = Calendar(identifier: .gregorian).date(byAdding: .day, value: -1, to: localizedDate)
        guard let dateString = dateFormatter.string(for: yesterday) else {
            return "알 수 없는 날짜"
        }
        return dateString
    }
}

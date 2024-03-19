//
//  dateFormmater.swift
//  BoxOffice
//
//  Created by dopamint on 3/12/24.
//

import Foundation

struct Formatter {
    func formatting() -> String? {
        let dateFormatter = DateFormatter()
        
        let today = Date()
        let timezone = TimeZone.autoupdatingCurrent
        let secondsFromGMT = timezone.secondsFromGMT(for: today)
        let localizedDate = today.addingTimeInterval(TimeInterval(secondsFromGMT))

        let yesterday = Calendar(identifier: .gregorian).date(byAdding: .day, value: -2, to: localizedDate)

        let dateString = dateFormatter.string(for: yesterday)
        
        return dateString
    }
}

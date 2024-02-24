//
//  Date+Extensions.swift
//  BoxOffice
//
//  Created by 박찬호 on 2/22/24.
//

import Foundation

extension Date {
    static var yesterdayFormatted: String {
        let yesterDayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyyMMdd"
        let convertNowStr = myDateFormatter.string(from: yesterDayDate ?? Date())
        
        return convertNowStr
    }
}

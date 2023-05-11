//
//  DateFormatter+.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/09.
//

import UIKit

extension Date {

    static func yesterDayDateConvertToString() -> String {
        let date = Date()
        guard let yesterDay = Calendar.current.date(byAdding: .day, value: -1, to: date) else { return "20220324" }
        let formatter = Formatter.dateWithDash

        return formatter.string(from: yesterDay)
    }

}

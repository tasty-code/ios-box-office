//
//  Date+Extension.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/04.
//

import Foundation

extension Date {

    var yesterday: String {
        let yesterdayDate = self - 86400
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMdd"

        return formatter.string(from: yesterdayDate)
    }
}

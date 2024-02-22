//
//  Date+Extension.swift
//  BoxOffice
//
//  Created by 강창현 on 2/22/24.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: self)
    }
}

//
//  Date+Extension.swift
//  BoxOffice
//
//  Created by 강창현 on 2/22/24.
//

import Foundation

extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

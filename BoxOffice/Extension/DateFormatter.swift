//
//  DateFormatter.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/02/22.
//

import Foundation

extension Date {
    func getYesterday(_ format: String) -> String {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: self) else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: yesterday)
    }
}

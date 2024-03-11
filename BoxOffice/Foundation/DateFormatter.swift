//
//  DateFormatter.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/02/22.
//

import Foundation

extension Date {
    static var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
    }
    
    enum Format: String {
        case standard = "yyyy-MM-dd"
        case apiFormat = "yyyyMMdd"
    }

    func formatted(using format: Format) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}

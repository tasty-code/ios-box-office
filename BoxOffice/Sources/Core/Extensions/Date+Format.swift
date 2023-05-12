//
//  Date+Format.swift
//  BoxOffice
//
//  Created by devxsby on 2023/05/08.
//

import Foundation

extension Date {
    
    static let secondsInADay: TimeInterval = 24 * 60 * 60 // 86400
    
    var previousDate: Date {
        self - Self.secondsInADay
    }
    
    func formatted(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
        
        return formatter.string(from: self)
    }
}

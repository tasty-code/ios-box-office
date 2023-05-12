//
//  Convertible.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/05/10.
//

import Foundation

protocol Convertible {
    func convertToNumberFormatter(_ audienceCount: String, accumulated: String) -> String
//    func receiveCurrentDate() -> String
    
    var receiveCurrentDate: String { get }
}

extension Convertible {
    var receiveCurrentDate: String {
        
        guard let date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateFormat = MagicLiteral.dateFormat
        let currentDateString = formatter.string(from: date)

        return currentDateString
    }
}

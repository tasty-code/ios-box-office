//
//  Gettable.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/05/11.
//

import Foundation

protocol Gettable {
    static var identifier: String { get }
    static var receiveCurrentDate: String { get }
}

extension Gettable {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var receiveCurrentDate: String {
        
        guard let date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateFormat = MagicLiteral.dateFormat
        let currentDateString = formatter.string(from: date)

        return currentDateString
    }
}

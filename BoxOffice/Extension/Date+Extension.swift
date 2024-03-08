//
//  Date+Extension.swift
//  BoxOffice
//
//  Created by 강창현 on 2/22/24.
//

import Foundation

extension Date {
    static let yesterday: Date = {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date() - 86400
    }()
    
    static let titleDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    static let movieDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter
    }()
    
    static let movieDateToString: String = {
        return movieDateFormatter.string(from: yesterday)
    }()
    
    static let titleDateToString: String = {
        return titleDateFormatter.string(from: yesterday)
    }()
}

//
//  DateFormatterTests.swift
//  BoxOfficeTests
//
//  Created by 강창현 on 3/8/24.
//

import XCTest

final class DateFormatterTests: XCTestCase {
    let dateFormatter = DateFormatter()
    let yesterday: Date = {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date() - 86400
    }()
    
    lazy var yesterdayToString: String = {
        return Date.toString(date: yesterday)
    }()
    
    func test_기존_Date_Extension_활용_효율성_검사() throws { // 0.001
        self.measure {
            for _ in (0..<500) {
                _ = yesterdayToString
            }
        }
    }
    
    func test_Date_Extension_static_키워드_활용_효율성_검사() throws { // 0.000
        self.measure {
            for _ in (0..<500) {
                _ = Date.yesterdayToString
            }
        }
    }
    
    func test_싱글턴_활용_효율성_검사() throws { // 0.002
        self.measure {
            for _ in (0..<500) {
                _ = Test.shared.yesterdayToString
            }
        }
    }
}

extension Date {
    static let df: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter
    }()
    
    static let yesterday: Date = {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date() - 86400
    }()
    
    static let yesterdayToString: String = {
        return toString(date: yesterday)
    }()
    
    static func toString(date: Date) -> String {
        return df.string(from: date)
    }
}

final class Test {
    static let shared = Test()
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date() - 86400
    }
    
    var yesterdayToString: String {
        return toString(date: yesterday)
    }
    
    private let df: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter
    }()
    
    func toString(date: Date) -> String {
        return df.string(from: date)
    }
}

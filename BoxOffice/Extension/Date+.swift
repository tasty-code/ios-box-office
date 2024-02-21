//
//  Date+.swift
//  BoxOffice
//
//  Created by EUNJU on 2/20/24.
//

import Foundation

extension Date {
    
    /// 어제 날짜를 String 타입으로 변환해 가져오는 메서드
    static func convertYesterdayDateToString() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        
        return format.string(from: yesterday)
    }
}


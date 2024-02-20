//
//  String+.swift
//  BoxOffice
//
//  Created by EUNJU on 2/20/24.
//

import Foundation

extension String {
    
    /// 어제 날짜를 String 타입으로 변환해 가져오는 메서드
    static func convertYesterdayDateToString() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? date
        let result = format.string(from: yesterday)
        
        return result
    }
}


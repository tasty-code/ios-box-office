//
//  Formatter.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/05/10.
//

import Foundation

struct Formatter: Convertible {
    func convertToNumberFormatter(_ audienceCount: String, accumulated: String) -> String {
        guard let audienceCount = Int(audienceCount), let audienceAccumulated = Int(accumulated) else {
            return ""
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        guard let audienceResult = numberFormatter.string(for: audienceCount),
                let audienceAccumulatedCount = numberFormatter.string(for: audienceAccumulated) else {
            return ""
        }

        return MagicLiteral.todayAudience + audienceResult + MagicLiteral.totalAudience + audienceAccumulatedCount
    }

    func receiveCurrentDate() -> String {
        guard let date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateFormat = MagicLiteral.dateFormat
        let currentDateString = formatter.string(from: date)

        return currentDateString
    }
}

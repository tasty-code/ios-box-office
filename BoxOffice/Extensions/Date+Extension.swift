//
//  Date+Extension.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/04.
//

import Foundation

extension Date {

    enum DateType {

        case network
        case title

        var format: String {
            switch self {
            case .network:
                return "YYYYMMdd"
            case .title:
                return "YYYY-MM-dd"
            }
        }
    }

    static var yesterday: Date {
        let today = Date()
        let secondOfDay: TimeInterval = 86400

        return today - secondOfDay
    }

    func formatData(type: DateType) -> String {

        let formatter = DateFormatter()

        switch type {
        case .network:
            formatter.dateFormat = type.format
        case .title:
            formatter.dateFormat = type.format
        }

        return formatter.string(from: self)
    }
}




//
//  DateHandlerable.swift
//  BoxOffice
//
//  Created by 강창현 on 2/25/24.
//

import Foundation

protocol DateHandlerable {
    var yesterday: Date { get }
}

extension DateHandlerable {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date() - 86400
    }
}

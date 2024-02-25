//
//  String+Extension.swift
//  BoxOffice
//
//  Created by 강창현 on 2/25/24.
//

import Foundation

extension String {
    func toDate() -> Date? {
        guard let result = self.split(separator: "~").last else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.date(from: Self(result))
    }
}

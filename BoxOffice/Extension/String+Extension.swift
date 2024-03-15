//
//  String+Extension.swift
//  BoxOffice
//
//  Created by 강창현 on 2/25/24.
//

import Foundation

extension String {
    func toDateFromRange() -> Date? {
        guard
            let result = self.split(separator: "~").last
        else {
            return nil
        }
        return Date.movieDateFormatter.date(from: Self(result))
    }
    
    var makeDateFormat: String {
        guard 
            let date = Date.movieDateFormatter.date(from: self)
        else {
            return "-"
        }
        return Date.titleDateFormatter.string(from: date)
    }
}

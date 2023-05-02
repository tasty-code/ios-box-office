//
//  NumberUtil.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/05/02.
//

import Foundation

enum NumberUtil {
    static func formatNumberWithCommas(_ numberString: String) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let number = Int(numberString) else { return nil }
        
        return numberFormatter.string(from: NSNumber(value: number))
    }
}

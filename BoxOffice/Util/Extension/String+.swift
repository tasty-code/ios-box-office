//
//  String+.swift
//  BoxOffice
//
//  Created by nayeon  on 2/26/24.
//

import Foundation

extension String {
    
    /// 숫자가 세 자리 이상 넘어가면 ,를 활용하는 메서드
    func formatNumberString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        if let number = Double(self) {
            return formatter.string(from: NSNumber(value: number)) ?? self
        }
        return self
    }
}

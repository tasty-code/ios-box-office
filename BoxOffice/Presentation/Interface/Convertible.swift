//
//  Convertible.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/05/10.
//

import Foundation

protocol Convertible {
    func convertToNumberFormatter(_ audienceCount: String, accumulated: String) -> String
    func receiveCurrentDate() -> String
}

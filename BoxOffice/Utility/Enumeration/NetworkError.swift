//
//  HTTPStatusError.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/15/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidStatusCode(Int)
}

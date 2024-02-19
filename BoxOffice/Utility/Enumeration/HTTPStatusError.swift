//
//  HTTPStatusError.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/15/24.
//

import Foundation

enum HTTPStatusError: LocalizedError {
    case invalidStatusCode(Int)
}

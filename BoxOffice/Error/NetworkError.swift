//
//  NetworkError.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/04/28.
//

import UIKit

enum NetworkError: Error {
    case transportError
    case missingData
    case decodingError
}

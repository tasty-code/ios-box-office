//
//  Result.swift
//  BoxOffice
//
//  Created by Roh on 2/14/24.
//

import Foundation

enum Result {
    case success(BoxOfficeResponseDTO)
    case failure(NetworkError)
}

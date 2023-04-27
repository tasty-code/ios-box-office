//
//  URLComponentsError.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/04/27.
//

import Foundation

enum URLComponentsError {
    case invalidComponent
}

extension URLComponentsError: LocalizedError {
    var errorDescription: String? {
        return NSLocalizedString("Component's requirements are not met \(self)", comment: "")
    }
}

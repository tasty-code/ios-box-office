//
//  URLComponentError.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/04/28.
//

import UIKit

enum URLComponentsError: Error {
    case invalidComponent
}

extension URLComponentsError: LocalizedError {
    var errorDescription: String? {
        return "Component's requirements are not met \(self)"
    }
}

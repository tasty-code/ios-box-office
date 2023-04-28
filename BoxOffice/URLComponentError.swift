//
//  URLComponentError.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/04/28.
//

import UIKit

enum URLComponentsError {
    case invalidComponent
}

extension URLComponentsError: LocalizedError {
    var errorDescription: String? {
        return NSLocalizedString("Component's requirements are not met \(self)", comment: "")
    }
}

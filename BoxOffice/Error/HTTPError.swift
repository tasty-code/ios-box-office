//
//  HTTPError.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/05/17.
//

import UIKit

enum HTTPError: Error {
    case requestError(message: String)
    case authenticationError(message: String)
    case authorizationPermissonError(message: String)
    case systemError(message: String)
    case serviceMaintenance(message: String)
    case notFound
}

extension HTTPError {
    var reason: String {
        switch self {
        case .requestError(let errorMessage):
            return errorMessage
        case .authenticationError(let errorMessage):
            return errorMessage
        case .authorizationPermissonError(let errorMessage):
            return errorMessage
        case .systemError(let errorMessage):
            return errorMessage
        case .serviceMaintenance(let errorMessage):
            return errorMessage
        case .notFound:
            return "Not Found Error"
        }
    }

}

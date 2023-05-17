//
//  ErrorDTO.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/05/17.
//

import UIKit

struct ErrorDTO: Decodable {
    let message: String?

    func convert(with httpCode: Int) -> HTTPError? {
        guard let message = message else { return nil }
        switch httpCode {
        case 200:
            return HTTPError.requestError(message: message)
        case 400:
            return HTTPError.requestError(message: message)
        case 401:
            return HTTPError.authenticationError(message: message)
        case 403:
            return HTTPError.authorizationPermissonError(message: message)
        case 500, 502:
            return HTTPError.systemError(message: message)
        case 503:
            return HTTPError.serviceMaintenance(message: message)
        default:
            return HTTPError.notFound
        }
    }
}

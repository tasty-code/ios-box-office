//
//  HTTPTask.swift
//  BoxOffice
//
//  Created by devxsby on 2023/04/27.
//

import Foundation

typealias QueryParameters = [String: String]

enum HTTPTask {
    case request
    case requestWithQueryParameters(queryParameters: QueryParameters)
}

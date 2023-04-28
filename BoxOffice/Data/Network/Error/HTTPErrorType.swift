//
//  HTTPErrorType.swift
//  BoxOffice
//
//  Created by Jason on 2023/04/28.
//

import Foundation

enum HTTPErrorType: Error {
    case redirectionMessages(_ statusCode: Int, _ description: String)
    case clientErrorResponses(_ statusCode: Int, _ description: String)
    case serverErrorResponses(_ statusCode: Int, _ description: String)
    case networkFailError(_ statusCode: Int)
}

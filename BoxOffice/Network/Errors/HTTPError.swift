//
//  HTTPError.swift
//  BoxOffice
//
//  Created by dopamint on 3/8/24.
//

enum HTTPError: Error {
    case redirectionMessages(_ statusCode: Int, _ description: String)
    case clientErrorResponses(_ statusCode: Int, _ description: String)
    case serverErrorResponses(_ statusCode: Int, _ description: String)
    case networkFailError(_ statusCode: Int)
}

//
//  NetworkSessionProtocol.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/04.
//

import Foundation

typealias NetworkResult = Result<Data, NetworkError>

protocol NetworkSessionProtocol {
    
    func data(from urlRequest: URLRequest) async throws -> NetworkResult
}

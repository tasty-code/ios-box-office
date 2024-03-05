//
//  NetworkSessionProtocol.swift
//  BoxOffice
//
//  Created by Roh on 2/20/24.
//

import Foundation

protocol NetworkSessionProtocol {
    func dataTask(
        with request: URLRequest,
        complection: @escaping (Result<Any, NetworkError>) -> Void
    )
}


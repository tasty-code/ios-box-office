//
//  kobisService.swift
//  BoxOffice
//
//  Created by Roh on 2/17/24.
//

import Foundation

protocol kobisService {
    func request() -> URLRequest?
    func response(request: URLRequest, completionHandler: @escaping (Result<Any, Error>) -> ())
    func setURL() -> URL?
}

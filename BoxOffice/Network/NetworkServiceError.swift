//
//  NetworkServiceError.swift
//  BoxOffice
//
//  Created by Effie on 2/19/24.
//

import Foundation

enum NetworkServiceError: Error {
  case urlError(error: URLError)
  case invalidHTTPResponse
  case noSuccess
}

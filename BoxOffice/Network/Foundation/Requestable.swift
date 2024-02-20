//
//  Requestable.swift
//  BoxOffice
//
//  Created by EUNJU on 2/20/24.
//

import Foundation

protocol Requestable {
    var requestTimeOut: Float { get }
    
    func request(_ request: URLRequest,
                 completion: @escaping (Result<NetworkResponse, Error>) -> Void)
}

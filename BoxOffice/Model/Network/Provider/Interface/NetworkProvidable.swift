//
//  NetworkProvidable.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/04.
//

import Foundation

protocol NetworkProvidable {
    
    func request<Endpoint: RequestResponseProtocol>(_ endpoint: Endpoint) async throws -> Result<Endpoint.Response, NetworkError>
}

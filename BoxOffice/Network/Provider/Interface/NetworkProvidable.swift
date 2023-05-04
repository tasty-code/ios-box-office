//
//  NetworkProvidable.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/04.
//

import Foundation

protocol NetworkProvidable {
    
    func request<EndPoint: RequestResponseProtocol>(_ endPoint: EndPoint) async throws -> Result<EndPoint.Response, NetworkError>
}

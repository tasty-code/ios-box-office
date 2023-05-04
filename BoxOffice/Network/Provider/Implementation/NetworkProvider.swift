//
//  NetworkProvider.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/04.
//

import Foundation

final class NetworkProvider: NetworkProvidable {
    
    private let session: NetworkSessionProtocol
    private let deserializer = JSONDeserializer()
    
    init(session: NetworkSessionProtocol) {
        self.session = session
    }
    
    func request<EndPoint: RequestResponseProtocol>(_ endPoint: EndPoint) async throws -> Result<EndPoint.Response, NetworkError> {
        
        let request = try endPoint.makeRequest()
        let result = try await session.data(from: request)
        
        switch result {
        case .success(let data):
            let decodingData: EndPoint.Response = try deserializer.deserialize(data)
            return .success(decodingData)
        case .failure(let error):
            return .failure(error)
        }
    }
    
}

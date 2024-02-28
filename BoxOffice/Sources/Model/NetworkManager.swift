//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Roh on 2/20/24.
//

import Foundation

struct NetworkManager<T: Decodable>: StatusCodeProtocol {
    
    private let networkSession: NetworkSessionProtocol
    private let networkRequestBuilder: NetworkRequestBuilderProtocol
    
    init(
        networkSession: NetworkSessionProtocol,
        networkRequestBuilder: NetworkRequestBuilderProtocol
    ) {
        self.networkSession = networkSession
        self.networkRequestBuilder = networkRequestBuilder
    }
    
    mutating func request(complection: @escaping (T?) -> Void) {
        let builder = networkRequestBuilder
        
        guard let request = builder.setURLRequest() else {
            return
        }
        
        networkSession.dataTask(with: request, complection: { [self] result in
            switch result {
            case .success(let networkResponse):
                let decoder = JsonDecoder.shared
                guard let networkResponse = networkResponse as? NetworkResponse,
                      let data = networkResponse.data,
                      let decodeData: T = try? decoder.decode(T.self, data)
                else {
                    complection(nil)
                    return
                }
                
                if !success.contains(networkResponse.response.statusCode) {
                    complection(nil)
                    return
                }
                
                complection(decodeData)
            case .failure(let error):
                print(error.errorDescription)
            }
        })
    }
}



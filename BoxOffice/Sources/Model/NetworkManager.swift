//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Roh on 2/20/24.
//

import Foundation

struct NetworkManager<T: Decodable> {
    private let networkSession: NetworkSessionProtocol
    private let networkRequestBuilder: NetworkRequestBuilderProtocol
    
    init(
        networkSession: NetworkSessionProtocol,
        networkRequestBuilder: NetworkRequestBuilderProtocol
    ) {
        self.networkSession = networkSession
        self.networkRequestBuilder = networkRequestBuilder
    }
    
    private func requestBuilder() {
        
    }
    
    mutating func request(complection: @escaping (Data) -> Void) {
        let builder = networkRequestBuilder
        
        guard let request = builder.setURLRequest() else {
            return
        }
//        let kobisSession = networkSession as! NetworkSession
        networkSession.dataTask(with: request, complection: { result in
            switch result {
            case .success(let networkResponse):
                guard let networkResponse = networkResponse as? NetworkResponse,
                      let data = networkResponse.data
                else {
                    return
                }
                complection(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    private mutating func resultHandler(with result: Result<Any, Error>) -> Data? {
        switch result {
        case .success(let networkResponse):
            guard let networkResponse = networkResponse as? NetworkResponse,
                  let data = networkResponse.data
            else {
                return nil
            }
            return data
        case .failure(let error):
            print(error.localizedDescription)
            return nil
        }
    }
}



//
//  BoxOfficeAPIManager.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/04/27.
//

import Foundation

struct BoxOfficeAPIManager {
    
    private let deserializer = JSONDeserializer()
    private let networkDispatcher = NetworkDispatcher()
    
    func fetchData(to type: Decodable.Type,
                   endPoint: BoxOfficeAPIEndpoints,
                   completionHandler: @escaping (Decodable) -> Void
    ) {
        let urlRequest = endPoint.urlRequest

        networkDispatcher.performRequest(urlRequest) { networkResult in
            switch networkResult {
            case .success(let data):
                do {
                    let decodedData = try deserializer.deserialize(type: type, data: data)
                    completionHandler(decodedData)
                }
                catch {
                    print(NetworkError.failedDecoding.errorDescription)
                }
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
    
}

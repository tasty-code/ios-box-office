//
//  BoxOfficeAPIManager.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/04/27.
//

import Foundation

struct NetworkAPIManager {

    private let deserializer = JSONDeserializer()
    let networkDispatcher = NetworkDispatcher()

    func fetchData(
        to type: Decodable.Type,
        endPoint: APIEndpoint) async throws -> Decodable? {
            let urlRequest = endPoint.urlRequest
            let result = try await networkDispatcher.performRequest(urlRequest)

            switch result {
            case .success(let data):
                let decodedData = try deserializer.deserialize(type: type, data: data)
                return decodedData
            case .failure(let error):
                print(error.errorDescription)
                return nil
            }
        }

}

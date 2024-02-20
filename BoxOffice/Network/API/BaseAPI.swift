//
//  BaseAPI.swift
//  BoxOffice
//
//  Created by EUNJU on 2/20/24.
//

import Foundation

class BaseAPI {
    
    let provider: NetworkProvider
    
    init(provider: NetworkProvider) {
        self.provider = provider
    }
    
    func judgeStatus<T: Decodable>(by statusCode: Int, 
                                   _ data: Data,
                                   _ type: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) 
        else {
            return .pathError
        }
        
        switch statusCode {
        case 200..<300:
            return .success(decodedData)
        case 400..<500:
            return .requestError(decodedData)
        case 500:
            return .serverError
        default:
            return .networkFail
        }
    }
}

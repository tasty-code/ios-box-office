//
//  MovieAPIService.swift
//  BoxOffice
//
//  Created by EUNJU on 2/20/24.
//

import Foundation

final class MovieAPIService: BaseAPIService {
    
    static let shared = MovieAPIService(provider: NetworkProvider())
    
    private override init(provider: Requestable) {
        super.init(provider: provider)
    }
    
    func requestMovieDetailAPI(userKey: String, movieCode: String,
                         completion: @escaping ((NetworkResult<Any>) -> Void)) {
        guard let request = try? MovieAPI
            .requestMovieDetailInfo(userKey: userKey, movieCode: movieCode)
            .creatURLRequest()
        else {
            completion(.networkFail)
            return
        }
        
        provider.request(request) { result in
            switch result {
            case .success(let result):
                let networkResult = self.judgeStatus(by: result.response.statusCode,
                                                     result.data,
                                                     MovieDTO.self)
                completion(networkResult)
            case .failure(_):
                completion(.networkFail)
            }
        }
    }
}

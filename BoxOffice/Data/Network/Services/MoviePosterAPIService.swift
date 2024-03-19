//
//  MoviePosterAPIService.swift
//  BoxOffice
//
//  Created by nayeon  on 3/19/24.
//

import Foundation

final class MoviePosterAPIService: BaseAPIService {
    
    override init(provider: Requestable) {
        super.init(provider: NetworkProvider())
    }
    
    func requestMoviePosterAPI(userKey: String, query: String, completion: @escaping ((NetworkResult<Any>) -> Void)) {
        guard let request = try? MoviePosterAPI
            .requestMoviePosterImage(userkey: userKey, query: query)
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
                                                     MoviePosterDTO.self)
                completion(networkResult)
            case .failure(_):
                completion(.networkFail)
            }
        }
    }
}

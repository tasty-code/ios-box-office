//
//  BoxOfficeAPI.swift
//  BoxOffice
//
//  Created by nayeon  on 2/20/24.
//

import Foundation

final class BoxOfficeAPI: BaseAPI {
    
    static let shared = BoxOfficeAPI(provider: NetworkProvider())
    
    private override init(provider: Requestable) {
        super.init(provider: provider)
    }
    
    func requestDailyBoxOfficeAPI(userKey: String, date: String,
                         completion: @escaping ((NetworkResult<Any>) -> Void)) {
        guard let request = try? BoxOfficeService
            .requestDailyBoxOfficeInfo(userkey: userKey, date: date)
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
                                                     BoxOfficeData.self)
                completion(networkResult)
            case .failure(_):
                completion(.networkFail)
            }
        }
    }
}

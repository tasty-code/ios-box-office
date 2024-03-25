//
//  DefaultBoxOfficeRepository.swift
//  BoxOffice
//
//  Created by EUNJU on 3/4/24.
//

import Foundation

final class DefaultBoxOfficeRepository: BoxOfficeRepository {
    
    private let apiService: BoxOfficeAPIService
    
    init(apiService: BoxOfficeAPIService) {
        self.apiService = apiService
    }
    
    func fetchBoxOfficeData(yesterday: String, completion: @escaping (NetworkResult<[BoxOfficeEntity]>) -> Void) {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else { return }
        
        apiService.requestDailyBoxOfficeAPI(userKey: apiKey, date: yesterday) { networkResult in
            switch networkResult {
            case .success(let data):
                if let dto = data as? BoxOfficeDTO {
                    DispatchQueue.main.async {
                        completion(.success(dto.boxOfficeResult.dailyBoxOfficeList
                            .map { $0.toDomain() }))
                    }
                }
            case .pathError:
                completion(.pathError)
            case .parsingError:
                completion(.parsingError)
            case .requestError:
                completion(.requestError)
            case .serverError:
                completion(.serverError)
            case .networkFail:
                completion(.networkFail)
            }
        }
    }
}

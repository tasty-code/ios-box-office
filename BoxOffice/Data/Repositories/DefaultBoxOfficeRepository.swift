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
    
    func fetchBoxOfficeData(completion: @escaping (Result<[BoxOfficeEntity], Error>) -> Void) {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else { return }
        let yesterday = Date.convertYesterdayDateToString()
        
        apiService.requestDailyBoxOfficeAPI(userKey: apiKey, date: yesterday) { networkResult in
            switch networkResult {
            case .success(let data):
                if let dto = data as? BoxOfficeDTO {
                    DispatchQueue.main.async {
                        completion(.success(dto.boxOfficeResult.dailyBoxOfficeList
                            .map { $0.toDomain() }))
                    }
                }
            default:
                // TODO: 에러 처리 필요
                print("error")
            }
        }
    }
}

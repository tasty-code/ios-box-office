//
//  BoxOfficeViewModel.swift
//  BoxOffice
//
//  Created by nayeon  on 2/26/24.
//

import Foundation

class BoxOfficeViewModel {
    
    private let boxOfficeAPI: BoxOfficeAPIService
    private var boxOfficeData: [BoxOfficeEntity] = []
    
    var boxOfficeCount: Int {
        return boxOfficeData.count
    }
    
    init(boxOfficeAPI: BoxOfficeAPIService = BoxOfficeAPIService.shared) {
        self.boxOfficeAPI = boxOfficeAPI
    }
    
    func fetchBoxOfficeData(completion: @escaping (Result<[BoxOfficeEntity], Error>) -> Void) {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else { return }
        let yesterday = Date.convertYesterdayDateToString()
        
        BoxOfficeAPIService.shared.requestDailyBoxOfficeAPI(userKey: apiKey, date: yesterday) { networkResult in
            switch networkResult {
            case .success(let data):
                if let boxOfficeData = data as? BoxOfficeDTO {
                    DispatchQueue.main.async {
                        self.handleBoxOfficeData(boxOfficeData)
                        completion(.success(self.boxOfficeData))
                    }
                }
            default:
                handleError(networkResult)
            }
        }
    }
    
    private func handleBoxOfficeData(_ data: BoxOfficeDTO) {
        let boxOfficeResult = data.boxOfficeResult
        let dailyBoxOfficeList = boxOfficeResult.dailyBoxOfficeList
        var entities: [BoxOfficeEntity] = []
        for boxOfficeItem in dailyBoxOfficeList {
            let isNewMovie = boxOfficeItem.rankOldAndNew == "NEW" ? true : false
            let entity = BoxOfficeEntity(rank: boxOfficeItem.rank,
                                         movieName: boxOfficeItem.movieName,
                                         salesAmount: boxOfficeItem.salesAmount,
                                         audienceCount: boxOfficeItem.audienceCount,
                                         rankChangeValue: boxOfficeItem.rankChangeValue,
                                         isNewMovie: isNewMovie)
            entities.append(entity)
        }
        self.boxOfficeData = entities
    }
    
    func boxOffice(at index: Int) -> BoxOfficeEntity {
        return boxOfficeData[index]
    }
}

private func handleError(_ networkResult: NetworkResult<Any>) {
    switch networkResult {
    case .pathError:
        print("pathErr")
    case .requestError(_):
        print("requestErr")
    case .networkFail:
        print("networkFail")
    case .serverError:
        print("serverErr")
    default:
        break
    }
}

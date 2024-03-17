//
//  DefaultMovieRepository.swift
//  BoxOffice
//
//  Created by nayeon  on 3/13/24.
//

import Foundation

final class DefaultMovieRepository: MovieRepository {
    
    private let apiService: MovieAPIService
    
    init(apiService: MovieAPIService) {
        self.apiService = apiService
    }
    
    func fetchMovieDetail(movieCode: String, completion: @escaping (NetworkResult<MovieEntity>) -> Void) {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else { return }
        
        apiService.requestMovieDetailAPI(userKey: apiKey, movieCode: movieCode) { result in
            switch result {
            case .success(let data):
                if let dto = data as? MovieDTO {
                    DispatchQueue.main.async {
                        let movieEntity = dto.movieInformationResult.detailMovieInformation.toEntity()
                        completion(.success(movieEntity))
                    }
                }
            case .pathError:
                completion(.pathError)
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

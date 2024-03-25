//
//  DefaultMoviePosterRepository.swift
//  BoxOffice
//
//  Created by nayeon  on 3/19/24.
//

import UIKit

final class DefaultMoviePosterRepository: MoviePosterRepository {
    
    private let apiService: MoviePosterAPIService
    
    init(apiService: MoviePosterAPIService) {
        self.apiService = apiService
    }
    
    func fetchMoviePoster(query: String, completion: @escaping (NetworkResult<MoviePosterEntity>) -> Void) {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_KEY") as? String else { return }

        apiService.requestMoviePosterAPI(userKey: apiKey, query: query) { result in
            switch result {
            case .success(let data):
                if let dto = data as? MoviePosterDTO,
                   let firstImageUrl = dto.documents.first?.imageURL {
                    self.loadImage(from: firstImageUrl) { result in
                        switch result {
                        case .success(let image):
                            let posterEntity = MoviePosterEntity(image: image)
                            DispatchQueue.main.async {
                                completion(.success(posterEntity))
                            }
                        case .failure:
                            completion(.networkFail)
                        }
                    }
                } else {
                    completion(.parsingError)
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
    
    private func loadImage(from imageUrl: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: imageUrl) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            completion(.success(image))
        }.resume()
    }
}

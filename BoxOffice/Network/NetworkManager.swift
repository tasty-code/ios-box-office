//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by 박찬호 on 2/20/24.
//
enum KobisRequesUrl: String {
    case apiKey = "f5eef3421c602c6cb7ea224104795888"
    case scheme = "http"
    case host = "kobis.or.kr"
    case path = "/kobisopenapi/webservice/rest"
    case detailPath = "/movie/searchMovieInfo.json"
    case dailyPath = "/boxoffice/searchDailyBoxOfficeList.json"
}

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let apiKey = KobisRequesUrl.apiKey.rawValue
    private let session = URLSession(configuration: .default)
    
    private init() {}
    
    private func performRequest<T: Decodable>(with url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.unknown(error?.localizedDescription)))
                return
            }
            let statusCode = response.statusCode
            switch statusCode {
            case 200..<300:
                guard let data = data, error == nil else {
                    completion(.failure(.unknown(error?.localizedDescription)))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.unknown(error.localizedDescription)))
                }
            case 100..<200:
                completion(.failure(.requestDelay(statusCode)))
            case 300..<400:
                completion(.failure(.insufficientRequest(statusCode)))
            case 400..<500:
                completion(.failure(.invalidRequest(statusCode)))
            case 500..<600:
                completion(.failure(.serverErorr(statusCode)))
            default:
                completion(.failure(.unknown(error?.localizedDescription)))
            }
        }
        task.resume()
    }
    
    func fetchDailyBoxOffice(for date: String, completion: @escaping (Result<BoxOfficeDTO, NetworkError>) -> Void) {
        var components = URLComponents()
        components.scheme = KobisRequesUrl.scheme.rawValue
        components.host = KobisRequesUrl.host.rawValue
        components.path = KobisRequesUrl.path.rawValue + KobisRequesUrl.dailyPath.rawValue
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "targetDt", value: date)
        ]
        
        guard let url = components.url else {
            completion(.failure(.badURL))
            return
        }
        
        performRequest(with: url) { (result: Result<BoxOfficeDTO, NetworkError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovieDetail(for movieCd: String, completion: @escaping (Result<MovieDetailDTO, NetworkError>) -> Void) {
        var components = URLComponents()
        components.scheme = KobisRequesUrl.scheme.rawValue
        components.host = KobisRequesUrl.host.rawValue
        components.path = KobisRequesUrl.path.rawValue + KobisRequesUrl.detailPath.rawValue
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "movieCd", value: movieCd)
        ]
        
        guard let url = components.url else {
            completion(.failure(.badURL))
            return
        }
        
        performRequest(with: url) { (result: Result<MovieInfoResponse, NetworkError>) in
            switch result {
            case .success(let data):
                let movie = data.movieInfoResult.movieInfo
                let movieDetail = MovieDetailDTO(movieCode: movie.movieCode,
                                                 movieName: movie.movieName,
                                                 movieNameEnglish: movie.movieNameEnglish,
                                                 runningTime: movie.runningTime,
                                                 productionYear: movie.productionYear,
                                                 openDate: movie.openDate,
                                                 status: movie.productionStatus,
                                                 movieType: movie.movieType,
                                                 genres: movie.genres.map { $0.genreName },
                                                 directors: movie.directors.map{ $0.peopleName }
                )
                completion(.success(movieDetail))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

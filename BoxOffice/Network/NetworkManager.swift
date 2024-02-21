//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by 박찬호 on 2/20/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let apiKey = "f5eef3421c602c6cb7ea224104795888"
    private let session = URLSession(configuration: .default)
    
    private init() {}
    
    func fetchDailyBoxOffice(for date: String, completion: @escaping (Result<[BoxOfficeMovieDTO], NetworkError>) -> Void) {
        let urlString = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(apiKey)&targetDt=\(date)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data,
                  error == nil else {
                completion(.failure(.requestFiled))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(BoxOfficeData.self, from: data)
                let boxOfficeMovies = result.boxOfficeResult.dailyBoxOfficeList.map { boxOffice -> BoxOfficeMovieDTO in
                    return BoxOfficeMovieDTO(rank: boxOffice.rank, 
                                             movieName: boxOffice.movieName,
                                             openDate: boxOffice.openDate,
                                             audienceCount: boxOffice.audienceCount,
                                             movicode: boxOffice.movieCd)
                }
                completion(.success(boxOfficeMovies))
            } catch {
                completion(.failure(.unknown))
            }
        }
        task.resume()
    }
    
    func fetchMovieDetail(for movieCd: String, completion: @escaping (Result<MovieDatailDTO, NetworkError>) -> Void) {
        let urlString = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(apiKey)&movieCd=\(movieCd)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data,
                  error == nil else {
                completion(.failure(.requestFiled))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(MovieInfoResponse.self, from: data)
                let data = result.movieInfoResult.movieInfo
                let movieDetail = MovieDatailDTO(movieCode: data.movieCode,
                                                 movieName: data.movieName,
                                                 movieNameEnglish: data.movieNameEn,
                                                 runningTime: data.runningTime,
                                                 productionYear: data.productionYear,
                                                 openDate: data.openDate,
                                                 status: data.productionStatus,
                                                 movieType: data.movieType,
                                                 genres: data.genres.map { $0.genreName },
                                                 directors: data.directors.map{ $0.peopleName })
                completion(.success(movieDetail))
            } catch {
                completion(.failure(.unknown))
            }
        }
        task.resume()
    }
}

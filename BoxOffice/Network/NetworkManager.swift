//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by 박찬호 on 2/20/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let apiKey = ""
    private let session = URLSession(configuration: .default)
    
    private init() {}
    
    // 일일 박스오피스 조회
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
                    return BoxOfficeMovieDTO(rank: boxOffice.rank, movieName: boxOffice.movieName, openDate: boxOffice.openDate, audienceCount: boxOffice.audienceCount, movicode: boxOffice.movieCd)
                }
                completion(.success(boxOfficeMovies))
            } catch {
                completion(.failure(.requestFiled))
            }
        }
        task.resume()
    }
    
    // 영화 상세 조회
    func fetchMovieDetail() {
        
    }
    
    
    
}

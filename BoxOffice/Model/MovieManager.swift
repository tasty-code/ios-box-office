//
//  MovieManager.swift
//  BoxOffice
//
//  Created by 강창현 on 2/13/24.
//

import Foundation

final class MovieManager {
    private var movieData: Movie?
}

extension MovieManager {
    typealias NetworkResult = (Result<Movie,NetworkError>)
    func fetchMovie(date: String, completion: @escaping (NetworkResult) -> ()) -> Movie? {
        guard
            let url: URL = URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=\(date)")
        else {
            completion(.failure(.invalidURLError))
            return nil
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponseError))
                return
            }
            
            switch response.statusCode {
            case 300..<400:
                return completion(.failure(.redirectionError))
            case 400..<500:
                return completion(.failure(.clientError))
            case 500..<600:
                return completion(.failure(.serverError))
            default:
                break
            }
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                do {
                    self.movieData = try JSONDecoder().decode(Movie.self, from: data)
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
        return movieData
    }
}

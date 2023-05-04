//
//  NetworkService.swift
//  BoxOffice
//
//  Created by 신동오 on 2023/05/03.
//

import Foundation

struct NetworkService {
    
    static func fetchBoxOfficeData(date: String, completion: @escaping (Result<DailyBoxOfficeDTO, Error>) -> Void) {
        URLSession.shared.dataTask(with: API.boxofficeMovie(date: date).urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  (200 ..< 300).contains(statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.dataNotFound))
                return
            }
            
            guard let parsedData = try? JSONDecoder().decode(DailyBoxOfficeDTO.self, from: data) else {
                completion(.failure(NetworkError.dataDecodingFailed))
                return
            }
            
            completion(.success(parsedData))
        }.resume()
    }
    
    static func fetchMovieData(code: String, completion: @escaping (Result<MovieDetailDTO, Error>) -> Void) {
        URLSession.shared.dataTask(with: API.movie(code: code).urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  (200 ..< 300).contains(statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.dataNotFound))
                return
            }
            
            guard let parsedData = try? JSONDecoder().decode(MovieDetailDTO.self, from: data) else {
                completion(.failure(NetworkError.dataDecodingFailed))
                return
            }
            
            completion(.success(parsedData))
        }.resume()
    }
    
}

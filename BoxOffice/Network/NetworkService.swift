//
//  NetworkService.swift
//  BoxOffice
//
//  Created by 신동오 on 2023/05/03.
//

import Foundation

struct NetworkService {
    
    static func fetchBoxOfficeData(date: String, completion: @escaping (DailyBoxOfficeDTO?) -> Void) {
        URLSession.shared.dataTask(with: API.boxofficeMovie(date: date).urlRequest) { data, response, error in
            guard error == nil else { return }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  (200 ..< 300).contains(statusCode) else { return }
            
            guard let data = data else { return }
            let parsedData = try? JSONDecoder().decode(DailyBoxOfficeDTO.self, from: data)
            completion(parsedData)
        }.resume()
    }
    
    static func fetchMovieData(code: String, completion: @escaping (MovieDetailDTO?) -> Void) {
        URLSession.shared.dataTask(with: API.movie(code: code).urlRequest) { data, response, error in
            guard error == nil else { return }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  (200 ..< 300).contains(statusCode) else { return }
            
            guard let data = data else { return }
            let parsedData = try? JSONDecoder().decode(MovieDetailDTO.self, from: data)
            completion(parsedData)
        }.resume()
    }
    
}

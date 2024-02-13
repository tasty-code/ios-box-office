//
//  MovieManager.swift
//  BoxOffice
//
//  Created by 강창현 on 2/13/24.
//

import Foundation

final class MovieManager {
    var movieData: Movie?
    func fetchMovie() {
        guard
            let url: URL = URL(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json")
        else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let error else { return }
            guard let response = response as? HTTPURLResponse else { return }
            
            switch response.statusCode {
            case 300..<400:
                return print(NetworkError.redirectionError)
            case 400..<500:
                return print(NetworkError.clientError)
            case 500..<600:
                return print(NetworkError.serverError)
            default:
                break
            }
            
            guard let data = data else { return }
            do {
                self.movieData = try JSONDecoder().decode(Movie.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

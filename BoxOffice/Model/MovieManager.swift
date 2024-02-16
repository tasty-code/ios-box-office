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
    private func fetchMovies(date: String, completion: @escaping (Result<Movie, NetworkError>) -> Void) {
        let apiService = APIService()
        let urlString = MovieURL.makeDailyBoxOfficeURL(date: date)
        
        apiService.fetchData(urlString: urlString) { (result: Result<Movie, NetworkError>) in
            switch result {
            case .success(let movies):
                completion(.success(movies))
                self.movieData = movies
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

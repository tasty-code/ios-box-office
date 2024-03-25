//
//  MovieUseCase.swift
//  BoxOffice
//
//  Created by nayeon  on 3/13/24.
//

import Foundation

protocol MovieUseCase {
    func fetchMovieDetail(movieCode: String, completion: @escaping (NetworkResult<MovieEntity>) -> Void)
}

final class DefaultMovieUseCase: MovieUseCase {
    
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func fetchMovieDetail(movieCode: String, completion: @escaping (NetworkResult<MovieEntity>) -> Void) {
        movieRepository.fetchMovieDetail(movieCode: movieCode) { result in
            completion(result)
        }
    }
}

//
//  MoviePosterUseCase.swift
//  BoxOffice
//
//  Created by nayeon  on 3/19/24.
//

import Foundation

protocol MoviePosterUseCase {
    func fetchMoviePoster(query: String, completion: @escaping (NetworkResult<MoviePosterEntity>) -> Void)
}

final class DefaultMoviePoserUseCase: MoviePosterUseCase {

    private let moviePosterRepository: MoviePosterRepository
    
    init(movieRepository: MoviePosterRepository) {
        self.moviePosterRepository = movieRepository
    }
    
    func fetchMoviePoster(query: String, completion: @escaping (NetworkResult<MoviePosterEntity>) -> Void) {
        moviePosterRepository.fetchMoviePoster(query: query) { result in
            completion(result)
        }
    }
}

//
//  MoviePosterRepository.swift
//  BoxOffice
//
//  Created by nayeon  on 3/19/24.
//

import Foundation

protocol MoviePosterRepository {
    func fetchMoviePoster(query: String, completion: @escaping
    (NetworkResult<MoviePosterEntity>) -> Void)
}

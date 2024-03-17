//
//  MovieRepository.swift
//  BoxOffice
//
//  Created by nayeon  on 3/13/24.
//

import Foundation

protocol MovieRepository {
    func fetchMovieDetail(movieCode: String, completion: @escaping 
    (NetworkResult<MovieEntity>) -> Void)
}

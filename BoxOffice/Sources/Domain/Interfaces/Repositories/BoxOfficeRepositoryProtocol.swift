//
//  BoxOfficeRepositoryProtocol.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/05/08.
//

import Foundation

protocol BoxOfficeRepositoryProtocol {
    typealias DailyBoxOfficeCompletion = (Result<DailyBoxOfficeResponse, NetworkError>) -> Void
    typealias MovieDetailCompletion = (Result<MovieDetailResponse, NetworkError>) -> Void
    
    func fetchDailyBoxOffice(endPoint: MovieEndPoint, completion: @escaping DailyBoxOfficeCompletion)
    func fetchMovieDetail(endPoint: MovieEndPoint, completion: @escaping MovieDetailCompletion)
}

//
//  MovieManager.swift
//  BoxOffice
//
//  Created by 강창현 on 2/13/24.
//

import Foundation

final class MovieManager {
    var boxOfficeData: BoxOffice?
    var movieDetailData: MovieInfomationDetail?
    var dailyBoxOfficeData: [DailyBoxOfficeList]?
    var movieCount: Int {
        self.dailyBoxOfficeData?.count ?? 0
    }
}

extension MovieManager {
    func fetchBoxOfficeResultData(
        date: String,
        completion: @escaping (Result<BoxOffice, NetworkError>) -> Void
    ) {
        let apiService = APIService()
        let urlString = MovieURL.makeDailyBoxOfficeURL(date: date)
        
        apiService.fetchData(urlString: urlString) { (result: Result<BoxOffice, NetworkError>) in
            switch result {
            case .success(let movies):
                completion(.success(movies))
                self.dailyBoxOfficeData = movies.boxOfficeResult.dailyBoxOfficeList
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovieInfoResultData(
        code: String,
        completion: @escaping (Result<MovieInfomationDetail, NetworkError>) -> Void
    ) {
        let apiService = APIService()
        let urlString = MovieURL.makeMovieInfomationDetailURL(code: code)
        
        apiService.fetchData(urlString: urlString) { (result: Result<MovieInfomationDetail, NetworkError>) in
            switch result {
            case .success(let movies):
                completion(.success(movies))
                self.movieDetailData = movies
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

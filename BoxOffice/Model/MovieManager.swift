//
//  MovieManager.swift
//  BoxOffice
//
//  Created by 강창현 on 2/13/24.
//

import Foundation

final class MovieManager {
    var movieDetailData: MovieInfomationDetail?
    var dailyBoxOfficeData: BoxOfficeResult?
    var movieCount: Int {
        self.dailyBoxOfficeData?.dailyBoxOfficeList.count ?? 0
    }
}

extension MovieManager {
    func fetchBoxOfficeResultData(
        date: String,
        completion: @escaping (Result<BoxOfficeResult, NetworkError>) -> Void
    ) {
        let apiService = APIService()
        let urlString = MovieURL.makeDailyBoxOfficeURL(date: date)
        
        apiService.fetchData(urlString: urlString) { [weak self] (result: Result<BoxOffice, NetworkError>) in
            switch result {
            case .success(let movies):
                self?.dailyBoxOfficeData = movies.boxOfficeResult
                guard let result = self?.dailyBoxOfficeData else { return }
                completion(.success(result))
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

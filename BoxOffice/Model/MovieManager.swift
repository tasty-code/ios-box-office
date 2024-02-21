//
//  MovieManager.swift
//  BoxOffice
//
//  Created by 강창현 on 2/13/24.
//

import Foundation

final class MovieManager {
    private var dailyBoxOfficeData: BoxOffice?
    private var movieDetailData: MovieInfomationDetail?
}

extension MovieManager: DateFormatable {
    private func fetchBoxOfficeResultData(date: String?, completion: @escaping (Result<BoxOffice, NetworkError>) -> Void) {
        let apiService = APIService()
        guard 
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        else {
            return
        }
        let urlString = MovieURL.makeDailyBoxOfficeURL(date: date ?? makeDataFormatToString(date: yesterday))
        
        apiService.fetchData(urlString: urlString) { (result: Result<BoxOffice, NetworkError>) in
            switch result {
            case .success(let movies):
                completion(.success(movies))
                self.dailyBoxOfficeData = movies
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchMovieInfoResultData(date: String, completion: @escaping (Result<MovieInfomationDetail, NetworkError>) -> Void) {
        let apiService = APIService()
        let urlString = MovieURL.makeDailyBoxOfficeURL(date: date)
        
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

//
//  MovieManager.swift
//  BoxOffice
//
//  Created by 강창현 on 2/13/24.
//

import UIKit

final class MovieManager {
    var dailyBoxOfficeData: BoxOfficeResult?
    private let movieRepository = MovieRepository()
    private var imageURL: String?
}

extension MovieManager {
    func setupBoxOfficeDetailData(for indexPath: Int) -> (movieName: String, movieCode: String)? {
        guard
            let movieName = dailyBoxOfficeData?.dailyBoxOfficeList[indexPath].name,
            let movieCode = dailyBoxOfficeData?.dailyBoxOfficeList[indexPath].code
        else {
            return nil
        }
        return (movieName, movieCode)
    }
    
    func fetchBoxOfficeResultData(date: String) async throws -> BoxOfficeResult {
        let result = try await movieRepository.fetchBoxOfficeResultData(date: date)
        switch result {
        case .success(let movies):
            let result = movies.boxOfficeResult
            self.dailyBoxOfficeData = result
            return result
        case .failure(let error):
            throw error
        }
    }
    
    func fetchMovieInfoResultData(code: String) async throws -> MovieInfo {
        let result = try await movieRepository.fetchMovieInfoResultData(code: code)
        switch result {
        case .success(let movies):
            let result = movies.movieInfoResult.movieInfo
            return result
        case .failure(let error):
            throw error
        }
    }
    
    func fetchMoiveImageURL(movieName: String) async throws {
        let result = try await movieRepository.fetchMoiveImageURL(movieName: movieName)
        switch result {
        case .success(let image):
            let movieImageData = image.documents[0]
            self.imageURL = movieImageData.imageURL
        case .failure(let error):
            throw error
        }
    }
    
    func fetchImageData() async throws -> Data? {
        guard let imageURL else { return nil }
        let result = try await movieRepository.fetchMovieImage(urlString: imageURL)
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
}

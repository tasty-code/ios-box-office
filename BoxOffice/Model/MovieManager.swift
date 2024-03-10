//
//  MovieManager.swift
//  BoxOffice
//
//  Created by 강창현 on 2/13/24.
//

import UIKit

final class MovieManager {
    var movieDetailData: MovieInfomationDetail?
    var dailyBoxOfficeData: BoxOfficeResult?
    var movieImageData: Document?
}

extension MovieManager {
    func fetchBoxOfficeResultData(
        date: String,
        completion: @escaping (Result<BoxOfficeResult, NetworkError>) -> Void
    ) {
        let apiService = APIService()
        let urlString = NetworkURL.makeDailyBoxOfficeURL(date: date)
        
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
        let urlString = NetworkURL.makeMovieInfomationDetailURL(code: code)
        
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
    
    func fetchMoiveImageData(
        movieName: String,
        completion: @escaping (Result<Document, NetworkError>) -> Void
    ) {
        let apiService = APIService()
        guard
            let urlString = NetworkURL.makeMovieImageURL(movieName: movieName)
        else {
            print("fetchMoiveImageData\(NetworkError.invalidURLError)")
            return
        }
        
        apiService.fetchImageData(urlRequest: urlString) { [weak self] (result: Result<MovieImage, NetworkError>) in
            switch result {
            case .success(let image):
                self?.movieImageData = image.documents[0]
                guard
                    let data = self?.movieImageData
                else {
                    return
                }
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func makeHttps(data: Document) -> String {
        let originUrl = data.imageURL
        var editingUrl = originUrl.components(separatedBy: "://")
        editingUrl[0] = "https"
        let resultUrl = "\(editingUrl[0])://\(editingUrl[1])"
        return resultUrl
    }
    
    func loadImage(data: Document,
                   completion: @escaping (Result<UIImage, NetworkError>) -> Void) -> UIImage? {
        let url = makeHttps(data: data)
        APIService().fetchData(urlString: url) { (result: Result<MovieImage, NetworkError>) in
            <#code#>
        }
//        guard
//            let url = URL(string: url),
//            let data = try? Data(contentsOf: url),
//            let image = UIImage(data: data)
//        else {
//            return nil
//        }
//        return image
    }
}

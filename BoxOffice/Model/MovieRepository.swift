//
//  MovieRepository.swift
//  BoxOffice
//
//  Created by 강창현 on 3/13/24.
//

import Foundation

struct MovieRepository {
    private let apiService = APIService.init()
    
    func fetchBoxOfficeResultData(date: String) async throws -> (Result<BoxOffice, NetworkError>) {
        guard
            let urlRequest = NetworkURL.makeURLRequest(type: .boxOffice(.dailyBoxOffice(date: date)))
        else {
            return .failure(.invalidURLRequestError)
        }
        
        let result = try await apiService.fetchData(with: urlRequest)
        switch result {
        case .success(let success):
            return handleDecodedData(data: success)
        case .failure(let failure):
            return .failure(failure)
        }
    }
    
    func fetchMovieInfoResultData(code: String) async throws -> (Result<MovieInfomationDetail, NetworkError>) {
        guard
            let urlRequest = NetworkURL.makeURLRequest(type: .boxOffice(.movieDetail(code: code)))
        else {
            return .failure(.invalidURLRequestError)
        }
        
        let result = try await apiService.fetchData(with: urlRequest)
        switch result {
        case .success(let success):
            return handleDecodedData(data: success)
        case .failure(let failure):
            return .failure(failure)
        }
    }
    
    func fetchMoiveImageURL(movieName: String) async throws -> (Result<MovieImage, NetworkError>) {
        guard
            let urlRequest = NetworkURL.makeURLRequest(type: .kakao(movieName: movieName))
        else {
            return .failure(.invalidURLRequestError)
        }
        
        let result = try await apiService.fetchData(with: urlRequest)
        switch result {
        case .success(let success):
            return handleDecodedData(data: success)
        case .failure(let failure):
            return .failure(failure)
        }
    }
    
    func fetchMovieImage(urlString: String) async throws -> (Result<Data, NetworkError>) {
        guard
            let url = URL(string: urlString)
        else {
            return .failure(.invalidURLError)
        }
        
        guard
            let urlRequest = NetworkURL.makeURLRequest(type: .image(url: url))
        else {
            return .failure(.invalidURLRequestError)
        }
        
        let result = try await apiService.fetchData(with: urlRequest)
        return result
    }
}

private extension MovieRepository {
    func handleDecodedData<T: Decodable>(data: Data?) -> (Result<T, NetworkError>) {
        guard
            let data = data
        else {
            return .failure(.noDataError)
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(.decodingError)
        }
    }
}

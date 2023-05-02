//
//  NetworkDispatcher.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/04/27.
//

import Foundation


struct NetworkDispatcher {

    typealias NetworkResult = Result<Data, NetworkError>

    func performRequest(_ urlRequest: URLRequest?,
                        completionHandler: @escaping (NetworkResult) -> Void
    ) {
        let session = URLSession.shared

        guard let urlRequest = urlRequest else {
            return completionHandler(.failure(.invalidURL))
        }

        let task = session.dataTask(with: urlRequest) { data, urlRequest, error in
            guard error == nil else {
                return completionHandler(.failure(.failedRequest))
            }
            guard let response = urlRequest, response.isValidResponse else {
                return completionHandler(.failure(.outOfResponseCode))
            }
            guard let data = data else {
                return completionHandler(.failure(.emptyData))
            }

            completionHandler(.success(data))
        }

        task.resume()
    }

}

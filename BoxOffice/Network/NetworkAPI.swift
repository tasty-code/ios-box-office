//
//  NetworkAPI.swift
//  BoxOffice
//
//  Created by dopamint on 2/17/24.
//

import Foundation

struct NetworkAPI {
    
    func buildDailyBoxOfficeAPI(targetDate: APIURLCompnents.QueryValues) -> URL? {
        return buildUrl(apiType: .dailyBoxOffice, query: targetDate).url
    }

    func buildMovieDetailAPI(movieCode: APIURLCompnents.QueryValues) -> URL? {
        return buildUrl(apiType: .movieDetail, query: movieCode).url
    }
    
    private func buildUrl(apiType: APIType, query: APIURLCompnents.QueryValues) -> URLComponents {
        var components = URLComponents()
        components.scheme = APIURLCompnents.schema
        components.host = APIURLCompnents.host
        components.path = apiType.makePath()
        
        components.queryItems = [
            URLQueryItem(name: "key", value: APIURLCompnents.QueryValues.APIKey.rawValue),
            URLQueryItem(name: apiType.rawValue , value: query.rawValue)
        ]
        return components
    }
}

extension NetworkAPI {
    func buildDailyBoxOfficeAPI(targetDate: APIURLCompnents.QueryValues, keys: APIURLCompnents.QueryKeys..., values: Any...) -> URL? {
        let dict: [APIURLCompnents.QueryKeys: Any] = zip(keys, values).reduce(into: [:]) { partialResult, now in
            partialResult[now.0] = now.1
        }
        return buildUrl(apiType: .dailyBoxOffice, requiredQuery: targetDate, queries: dict).url
    }
    
    private func buildUrl(apiType: APIType, requiredQuery: APIURLCompnents.QueryValues, queries: [APIURLCompnents.QueryKeys: Any]) -> URLComponents {
        var components = URLComponents()
        components.scheme = APIURLCompnents.schema
        components.host = APIURLCompnents.host
        components.path = apiType.makePath()

        components.queryItems = [
            URLQueryItem(name: "key", value: APIURLCompnents.QueryValues.APIKey.rawValue),
            URLQueryItem(name: apiType.rawValue , value: requiredQuery.rawValue)
        ]
        queries.forEach { (key: APIURLCompnents.QueryKeys, value: Any) in
            components.queryItems?.append(URLQueryItem(name: key.rawValue,
                                                       value: value as? String))
        }
        return components
    }
}

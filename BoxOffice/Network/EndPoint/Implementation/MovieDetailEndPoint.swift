//
//  MovieDetailAPI.swift
//  BoxOffice
//
//  Created by J.E on 2023/05/08.
//

import Foundation

struct MovieDetailEndPoint: EndPointProtocol {
    
    typealias DTO = MovieDetailDTO
    
    var baseURL: URL? {
        return URL(string: "https://kobis.or.kr/")
    }
    
    var method: HTTPMethodType {
        return .get
    }
    
    var path: String {
        return "kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
    }
    
    var queryParameters: [String: String]
    
    init(movieCode: String) {
        self.queryParameters = ["key": "f5eef3421c602c6cb7ea224104795888", "movieCd": movieCode]
    }
    
}

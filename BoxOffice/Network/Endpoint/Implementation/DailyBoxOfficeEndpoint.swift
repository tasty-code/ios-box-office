//
//  DailyBoxOfficeEndpoint.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/04.
//

import Foundation

struct DailyBoxOfficeEndpoint: RequestResponseProtocol {
    
    typealias Response = BoxOfficeDTO
    
    var scheme: String
    var host: String
    var path: String?
    var query: [URLQueryItem]?
    var headers: [String : String]?
    
    init(date: String) {
        let api = MovieAPI.dailyBoxOffice(date)
        
        self.scheme = MovieAPI.scheme
        self.host = MovieAPI.host
        self.path = api.path
        self.query = api.query
    }
}

//
//  MovieInformationEndpoint.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/04.
//

import Foundation

struct MovieInformationEndpoint: RequestResponseProtocol {
    
    typealias Response = MovieInformationDTO
    
    var scheme: String
    var host: String
    var path: String?
    var query: [URLQueryItem]?
    var headers: [String : String]?
    
    init(movieCode: String) {
        let api = MovieAPI.movieInformation(movieCode)
        
        self.scheme = MovieAPI.scheme
        self.host = MovieAPI.host
        self.path = api.path
        self.query = api.query
    }
}

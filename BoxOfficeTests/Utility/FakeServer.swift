//
//  FakeServer.swift
//  BoxOfficeTests
//
//  Created by LeeSeongYeon on 2024/02/15.
//

import Foundation
@testable import BoxOffice

struct FakeServer {
    static let fakeURL_MovieDetailInformation: String = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=f5eef3421c602c6cb7ea224104795888&movieCd=20124079"
    static let fakeURL_DailyBoxOffice: String = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20220105"
    
    static func data(from url: URL) throws -> (Data?, HTTPURLResponse?) {
        let type: KoreanFilmCouncilURLEnumeration?
        if url.absoluteString.contains("searchDailyBoxOfficeList") {
            type = .dailyBoxOffice("", "")
        } else if url.absoluteString.contains("searchMovieInfo") {
            type = .movieDetailInformation("", "")
        } else {
            throw HTTPStatusError.clientError
        }
        
        switch type {
        case .dailyBoxOffice("", ""):
            guard fakeURL_DailyBoxOffice == url.absoluteString else {
                throw HTTPStatusError.clientError
            }
            
            guard let sample = Bundle.main.url(forResource: "box_office_sample", withExtension: "json") else {
                throw HTTPStatusError.serverError
            }
            
            let input = try Data(contentsOf: sample)
            
            return (input, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil))
        
        case .movieDetailInformation("", ""):
            guard fakeURL_MovieDetailInformation == url.absoluteString else {
                throw HTTPStatusError.clientError
            }
            
            guard let sample = Bundle.main.url(forResource: "movie_info_sample", withExtension: "json") else {
                throw HTTPStatusError.serverError
            }
            
            let input = try Data(contentsOf: sample)
            
            return (input, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil))
        
        default:
            throw HTTPStatusError.clientError
        }
    }
}

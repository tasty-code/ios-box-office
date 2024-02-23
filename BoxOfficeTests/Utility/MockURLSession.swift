//
//  MockURLSession.swift
//  BoxOfficeTests
//
//  Created by LeeSeongYeon on 2024/02/15.
//

import Foundation
@testable import BoxOffice

struct MockURLSession: URLSessionProtocol {
    let successSampleBoxOffice: (Data, URLResponse)? = MockURLSession.makeSample(with: "sample_searchDailyBoxOfficeList", queryValue: "20220105")
    
    let successSampleMovieInformation: (Data, URLResponse)? = MockURLSession.makeSample(with: "sample_searchMovieInfo", queryValue: "20124079")
    
    let failure: NetworkError = .invalidURL
    
    func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)? = nil) async throws -> (Data, URLResponse) {
        let lastPathComponent = request.url?.lastPathComponent
        let last = request.url?.query
        
        if lastPathComponent == "searchDailyBoxOfficeList.json", last!.contains("20220105") {
            return successSampleBoxOffice!
        }
        
        if lastPathComponent == "searchMovieInfo.json", last!.contains("20124079") {
            return successSampleMovieInformation!
        }

        throw failure
    }
    
    static func makeSample(with fileURL: String, queryValue: String) -> (Data, URLResponse)? {
        do {
            let sampleUrl = Bundle.main.url(forResource: fileURL, withExtension: "json")
            let data = try Data(contentsOf: sampleUrl!)
            let url: String
            if fileURL == "searchDailyBoxOfficeList" {
                url = KoreanFilmCouncilURL.dailyBoxOffice(targetDate: "20220105").url
            } else {
                url = KoreanFilmCouncilURL.movieDetailInformation(movieCode: queryValue).url
            }
            let response = HTTPURLResponse(url: URL(string: url)!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (data, response)
        } catch {
            print(error)
            return nil
        }
    }
}

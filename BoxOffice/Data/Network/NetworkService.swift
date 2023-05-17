//
//  NetworkService.swift
//  BoxOffice
//
//  Created by Jason on 2023/04/27.
//

import Foundation

final class NetworkService {

    //MARK: - Initializer
    
    init() {
        self.session = URLSession(configuration: .default)
    }
    
    //MARK: - Method
    
    func loadData(completion: @escaping ([DailyBoxOfficeList]) -> Void) {
        
        Task {
            let yesterdayDate = Getter.receiveCurrentDate.split(separator: "-").joined()
            let boxOfficeQueryParameters = BoxOfficeQueryParameters(targetDate: yesterdayDate)
            let networkResult = try await request(with: APIEndPoint.receiveBoxOffice(with: boxOfficeQueryParameters)).boxOfficeResult.dailyBoxOfficeList

            completion(networkResult)
        }
    }
    
    //MARK: - Private Method

    private func request<R: Decodable, E: RequestAndResponsable>(with endPoint: E) async throws -> R where E.Responese == R {

        let urlRequest = try endPoint.receiveURLRequest()
        let (data, response) = try await session.data(for: urlRequest)

        if let identifiedResponse = response as? HTTPURLResponse, !(200...299).contains(identifiedResponse.statusCode) {
            try self.verify(with: identifiedResponse)
        }

        let decodedData: R = try self.decode(with: data)

        return decodedData
    }

    private func verify(with HTTPResponse: HTTPURLResponse) throws {

        switch HTTPResponse.statusCode {
        case (300...399):
            throw HTTPErrorType.redirectionMessages(HTTPResponse.statusCode, HTTPResponse.debugDescription)
        case (400...499):
            throw HTTPErrorType.clientErrorResponses(HTTPResponse.statusCode, HTTPResponse.debugDescription)
        case (500...599):
            throw HTTPErrorType.serverErrorResponses(HTTPResponse.statusCode, HTTPResponse.debugDescription)
        default:
            throw HTTPErrorType.networkFailError(HTTPResponse.statusCode)
        }
    }

    private func decode<T: Decodable>(with apiData: Data) throws -> T {

        var decode: T
        let decoder = JSONDecoder()

        do {
            decode = try decoder.decode(T.self, from: apiData) as T
        } catch {
            throw NetworkError.decodeError
        }

        return decode
    }
    
    //MARK: - Private Property

    private let session: URLSession
}

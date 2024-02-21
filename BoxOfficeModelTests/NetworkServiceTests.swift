import XCTest
import Foundation

@testable import BoxOffice

final class MockNetworkSessionManager: NetworkSessionManager {
    func request(_ request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask {
        let fileName = request.url?.path() ==  "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
            ? "box_office_sample_2"
            : "movie_detail_sample"
        let mockData = JsonLoader.loadjson(fileName: fileName)
        completion(mockData, nil, nil)
        let task = URLSessionTask()
        return task
    }
}

final class NetworkServiceTests: XCTestCase {

    func test_네트워크_서비스를_통해_박스오피스_데이터를_불러올_수_있다() throws {
        // given
        let baseUrl = "kobis.or.kr"
        let path = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        let queryParameters = [
            "key": "f5eef3421c602c6cb7ea224104795888",
            "targetDt": "20120101"
        ]
        let boxOfficeAPI = APIConfig<BoxOfficeResponseDTO>(baseURL: baseUrl,
                                                           path: path,
                                                           queryParameters: queryParameters)
        let mockNetworkSessionManager = MockNetworkSessionManager()
        let sut = DefaultNetworkService(sessionManager: mockNetworkSessionManager)
        let expectation = XCTestExpectation(description: "dataFectch")
        // when
        _ = sut.request(apiConfig: boxOfficeAPI) { result in
            // then
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                print(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    func test_네트워크에서_불러온_json을_BoxOfficeResponseDTO로_파싱할_수_있다() throws {
        // given
        let baseUrl = "kobis.or.kr"
        let path = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        let queryParameters = [
            "key": "f5eef3421c602c6cb7ea224104795888",
            "targetDt": "20120101"
        ]
        let boxOfficeAPI = APIConfig<BoxOfficeResponseDTO>(baseURL: baseUrl,
                                                           path: path,
                                                           queryParameters: queryParameters)
        let mockNetworkSessionManager = MockNetworkSessionManager()
        let sut = DefaultDataTransferService(with: DefaultNetworkService(sessionManager: mockNetworkSessionManager))
        let decoder = JSONDecoder()
        let expectationData = try decoder.decode(BoxOfficeResponseDTO.self,
                                                 from: JsonLoader.loadjson(fileName: "box_office_sample_2")!)
        let expectation = XCTestExpectation(description: "dataFectch")
        // when
        _ = sut.request(with: boxOfficeAPI) { result in
            // then
            switch result {
            case .success(let data):
                XCTAssertEqual(data.boxOfficeResult.boxOfficeType, expectationData.boxOfficeResult.boxOfficeType)
            case .failure(let error):
                print(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    func test_네트워크에서_불러온_json을_MovieDetailResponseDTO로_파싱할_수_있다() throws {
        // given
        let baseUrl = "kobis.or.kr"
        let path = "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        let queryParameters = [
            "key": "f5eef3421c602c6cb7ea224104795888",
            "movieCd": "20124079"
        ]
        let movieDetailAPI = APIConfig<MovieDetailResponseDTO>(baseURL: baseUrl,
                                                           path: path,
                                                           queryParameters: queryParameters)
        let mockNetworkSessionManager = MockNetworkSessionManager()
        let sut = DefaultDataTransferService(with: DefaultNetworkService(sessionManager: mockNetworkSessionManager))
        let decoder = JSONDecoder()
        let expectationData = try decoder.decode(MovieDetailResponseDTO.self,
                                                 from: JsonLoader.loadjson(fileName: "movie_detail_sample")!)
        let expectation = XCTestExpectation(description: "dataFectch")
        // when
        _ = sut.request(with: movieDetailAPI) { result in
            // then
            switch result {
            case .success(let data):
                print(data)
                XCTAssertEqual(data.movieInfoResult.movieInfo.movieCode,
                               expectationData.movieInfoResult.movieInfo.movieCode)
            case .failure(let error):
                print(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
}

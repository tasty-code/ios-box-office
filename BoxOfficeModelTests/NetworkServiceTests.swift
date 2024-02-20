import XCTest
import Foundation

@testable import BoxOffice

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
        let sessionManager = DefaultNetworkSessionManager()
        let sut = DefaultNetworkService(sessionManager: sessionManager)
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
        let sessionManager = DefaultNetworkSessionManager()
        let sut = DefaultDataTransferService(with: DefaultNetworkService(sessionManager: sessionManager))
        let decoder = JSONDecoder()
        let expectationData = try decoder.decode(BoxOfficeResponseDTO.self,
                                                 from: JsonLoader.loadjson(fileName: "box_office_sample_2")!)
        let expectation = XCTestExpectation(description: "dataFectch")
        // when
        _ = sut.request(with: boxOfficeAPI) { result in
            // then
            switch result {
            case .success(let data):
                XCTAssertEqual(data, expectationData)
            case .failure(let error):
                print(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

}

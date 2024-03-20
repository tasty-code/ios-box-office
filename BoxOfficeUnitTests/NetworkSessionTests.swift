
import XCTest
@testable import BoxOffice

class NetworkSessionTests: XCTestCase {
    
    var sessionProvider: SessionProvider!
    var urlSession: URLSession!
    
    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: config)
        
        sessionProvider = SessionProvider(session: urlSession)
    }
    
    override func tearDown() {
        super.tearDown()
        urlSession = nil
        sessionProvider = nil
    }
    
    func test_givenMockSuccessfulResponse_whenLoadAPIRequest_thenSuccessResult() async {
        
        // Given
        let stubData = StubData.boxOfficeJSON
        let stubReqeust = URLRequest(url: URL(string:"https://example.com")!)
        let mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
        
        MockURLProtocol.requestHandler = { request in
            return (mockResponse, stubData)
        }
        
        // When
        let result = await sessionProvider.requestAPI(using: stubReqeust)
        
        // Then
        switch result {
        case .success(let networkResponse):
            XCTAssertNotNil(networkResponse.data)
            XCTAssertEqual(networkResponse.response.statusCode, 200)
        case .failure(let error):
            XCTFail("\(error)")
        }
    }
    
    func test_givenMockConnectivityError_whenLoadAPIRequest_thenConnectivityErrorResult() async {
        
        // Given
        let stubReqeust = URLRequest(url: URL(string:"https://example.com")!)
        
        MockURLProtocol.requestHandler = { request in
            throw URLError(.notConnectedToInternet)
        }
        
        // When
        let result = await sessionProvider.requestAPI(using: stubReqeust)
        
        // Then
        if case .failure(let error) = result,
           case .connectivity = error {
            XCTAssertTrue(true)
        } else {
            XCTFail("error")
        }
    }
}
